var MetaCoin = artifacts.require('MetaCoin')
var RelayHub = artifacts.require('./tabookey-gasless/contracts/RelayHub.sol')

contract('MetaCoin', async () => {
  it('deposit the MetaCoin on relay hub', async () => {
    let meta = await MetaCoin.deployed() //at('0x9b1f7f645351af3631a656421ed2e40f2802e6c0')
    console.log('meta adddr=', meta.address)

    let hubaddr
    try {
      hubaddr = await meta.get_hub_addr()
    } catch (e) {
      assert.ok(0, 'RelayHub not deployed. must restart it from tabookey-gasless project itself: '+e)
    }
    console.log('hub addr=', hubaddr)
    let hub = RelayHub.at(hubaddr)

    let b1 = await hub.balanceOf(meta.address)
    console.log('pre deposit balance', b1.toNumber())
    hub.depositFor(meta.address, { value: 1e17 })

    let b2 = await hub.balanceOf(meta.address)
    console.log('post deposit balance', b2.toNumber())
  })
})
