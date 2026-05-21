Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C058D395DAA;
	Thu, 21 May 2026 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358930; cv=none; b=jWa8AbREWjX8gUzq/AWCxwM/7+T+oWFqEwglQkAQoUAiw7YlQykbOv4jMSAhafh4MHVVPO6RjLMXkvduvVbZYYhp21Fmu9XN45D83wqMWbLXXetIQz/3+b6y2T60PeHjAlFLJPKIr6mVThnRhvhdg6xZJmsFm+MQI64reDvpeFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358930; c=relaxed/simple;
	bh=wLBV9dHx2IIFJVLTTy6QNLmeWEIdf3Qkdd4z4qJrUtI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NakvmOGnFjMKtLz88FiDlvBLPbd4OB8BKOjfRXc21N4lZe1brjVH/4LXMBA8d+rPn4wlLTIxYwwdsRjoDQMBEZPeX42ae2ljOTy8tmXtJHaTLFv49iA8IZcugfzL/kkFDPb/fCg1RMpaELpWwCY8spzKRYgTLF/Q73ONd0ZT/qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=ONZ5zvJv; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="ONZ5zvJv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1779358914; x=1779963714; i=spasswolf@web.de;
	bh=4FoIHMcOrI635YiW+HyzjAWHWLQFgvtUGIwIwRoN2Fk=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ONZ5zvJvim4JAr5zCS15qVg/vuq1/VN5O2/tDzF/N2BD7hFBmskdumdE+bygOhMB
	 Xbzy1x31ZhXkNkeuM4SXfhlJAY7BaRskuqtD7TWdTJXBpOHjKr2x40mrE0eF3J8PC
	 urM1MecCv2ou8R9QD+hnGcvXMJpuSVGth3Eeor/KMKo+nUUaL4vZuBtKNTmRVk7S4
	 xg3D/2Ovhb3GAP1972smk8dpY8rpDVqWjKRa7F6TI+nOurxJw+BI/Te8q0eyLOKfc
	 MKLcPyqqZUWC/WrUBGS5IpUsCE+CZh0IlHi4h1KlHWwRVCNpTs2taP+lvIFUFUPCf
	 XhA9TvUtqpYuwDKFoQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MA4bO-1wW5M00zc2-002ew9; Thu, 21
 May 2026 12:21:54 +0200
Message-ID: <50e5e76bc13256e3f5b3301e92f159957c3d6762.camel@web.de>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Thomas Gleixner <tglx@linutronix.de>, Mateusz Guzik <mjguzik@gmail.com>,
  Christian Brauner	 <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	adobriyan@gmail.com, jack@suse.cz, viro@zeniv.linux.org.uk, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, spasswolf@web.de, Alex Deucher
 <alexander.deucher@amd.com>, 	amd-gfx@lists.freedesktop.org
Date: Thu, 21 May 2026 12:21:52 +0200
In-Reply-To: <878q9dvzh0.ffs@tglx>
References: <20260520225245.2962-1-spasswolf@web.de>
	 <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
	 <s7cu3dpioidx6mepmai6eyj2pxjs4skbw7v534zbzs6g2fwcis@cvokidcxy3xa>
	 <4f548d61b2dd12e01f401ce4b8c865f238f7b23c.camel@web.de>
	 <878q9dvzh0.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4iP9zOnKni3WV6YMmhQUFkbEWic3hGUhYQhXDwRDRWq2hYiJY0W
 eFPLypcpDfmDZuyJA+BbYai2x0AK8VP0xiYEfA5/+D70TIcVJUeh9AhafsOVb3FgUFxudsz
 4p9x2Ai8OVNMdG+3AJdfltptywJGyyun1KT2d1e1zUkHbE3KjNkB5uOAwPv3/QNg1l/wYVN
 6S6GhXbshw4V8jbL+vjLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/dO5PnXFxJ8=;m8CgoCPxMhMrm26C+D+/GoAngAS
 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

Am Donnerstag, dem 21.05.2026 um 12:17 +0200 schrieb Thomas Gleixner:
> On Thu, May 21 2026 at 11:20, Bert Karwatzki wrote:
> > Am Donnerstag, dem 21.05.2026 um 11:09 +0200 schrieb Mateusz Guzik:
> >=20
> > with next-20260519 (no RT, no LOCKDEP) and got no crash so far (4 boot=
s only though (next-20260619
> > crashed in 2 out of 3 boots without RT)) but I get this warning on eve=
ry boot:
> >=20
> > [    2.793416] [    T331] ------------[ cut here ]------------
> > [    2.793433] [    T331] DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
> > [    2.793434] [    T331] WARNING: kernel/locking/mutex.c:625 at __mut=
ex_lock+0x586/0x10c0, CPU#17: (udev-worker)/331
>=20
> So either the mutex is corrupted or was never initialized.
>=20
> > [    2.793463] [    T331] Modules linked in: amdgpu(+) hid_generic usb=
hid drm_client_lib i2c_algo_bit drm_buddy hid drm_ttm_helper ttm drm_exec
> > drm_suballoc_helper mfd_core drm_panel_backlight_quirks gpu_sched amdx=
cp drm_display_helper drm_kms_helper ahci libahci xhci_pci libata xhci_hcd=
 drm nvme
> > scsi_mod igc usbcore nvme_core scsi_common video nvme_keyring i2c_piix=
4 cec nvme_auth usb_common crc16 i2c_smbus wmi gpio_amdpt gpio_generic
> > [    2.793518] [    T331] CPU: 17 UID: 0 PID: 331 Comm: (udev-worker) =
Not tainted 7.1.0-rc4-next-20260519-rcunortlockdep-dirty #465 PREEMPT=20
> > [    2.793534] [    T331] Hardware name: ASUS System Product Name/ROG =
STRIX B850-F GAMING WIFI, BIOS 1627 02/05/2026
> > [    2.793547] [    T331] RIP: 0010:__mutex_lock+0x58d/0x10c0
> > [    2.793555] [    T331] Code: 4c 8b 4d 88 85 c0 0f 84 f8 fa ff ff 44=
 8b 15 ca 9b 81 00 45 85 d2 0f 85 e8 fa ff ff 48 8d 3d 1a 57 82 00 48 c7 c=
6 a6 51 9e 83
> > <67> 48 0f b9 3a 4c 8b 4d 88 e9 cc fa ff ff 48 8b bd 78 ff ff ff e8
> > [    2.793579] [    T331] RSP: 0018:ffffa497016c3510 EFLAGS: 00010246
> > [    2.793588] [    T331] RAX: 0000000000000001 RBX: ffff88c33a4c2ad8 =
RCX: 0000000000000000
> > [    2.793598] [    T331] RDX: 0000000000000001 RSI: ffffffff839e51a6 =
RDI: ffffffff83de3c00
> > [    2.793609] [    T331] RBP: ffffa497016c35c0 R08: ffffffffc0a55d92 =
R09: 0000000000000000
> > [    2.793619] [    T331] R10: 0000000000000000 R11: 0000000000000000 =
R12: 0000000000000000
> > [    2.793629] [    T331] R13: 0000000000000002 R14: ffffa497016c3550 =
R15: 0000000000268000
> > [    2.793641] [    T331] FS:  00007f1f32e5b9c0(0000) GS:ffff88d23b2ca=
000(0000) knlGS:0000000000000000
> > [    2.793653] [    T331] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
> > [    2.793662] [    T331] CR2: 000055cdfa28f588 CR3: 0000000112e73000 =
CR4: 0000000000f50ef0
> > [    2.793673] [    T331] PKRU: 55555554
> > [    2.793678] [    T331] Call Trace:
> > [    2.793683] [    T331]  <TASK>
> > [    2.793687] [    T331]  ? lock_acquire+0xbe/0x2d0
> > [    2.793696] [    T331]  ? init_mqd+0x122/0x190 [amdgpu]
> > [    2.793809] [    T331]  ? lock_release+0xc6/0x2a0
> > [    2.793816] [    T331]  ? init_mqd+0x122/0x190 [amdgpu]
> > [    2.793902] [    T331]  init_mqd+0x122/0x190 [amdgpu]
> > [    2.793961] [    T331]  init_mqd_hiq+0xd/0x20 [amdgpu]
> > [    2.794015] [    T331]  kq_initialize.constprop.0+0x2b8/0x370 [amdg=
pu]
> > [    2.794071] [    T331]  kernel_queue_init+0x3f/0x60 [amdgpu]
> > [    2.794125] [    T331]  pm_init+0x6b/0x100 [amdgpu]
> > [    2.794178] [    T331]  start_cpsch+0x1d6/0x270 [amdgpu]
> > [    2.794234] [    T331]  kgd2kfd_device_init.cold+0x7b9/0xa1a [amdgp=
u]
> > [    2.794365] [    T331]  amdgpu_amdkfd_device_init+0x190/0x260 [amdg=
pu]
>=20
> amdgpu_amdkfd_device_init()
>   kgd2kfd_device_init() {
>       ....
>         init_mqd()
>           mutex_lock(... profiler_lock); <- FAIL
>=20
>       mutex_init(...profiler_lock);
>   }
>=20
> Seems the famous graphics CI failed to catch this...
>=20
> Thanks,
>=20
>         tglx
> ---
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -744,6 +744,9 @@ bool kgd2kfd_device_init(struct kfd_dev
>  			KGD_ENGINE_SDMA1);
>  	kfd->shared_resources =3D *gpu_resources;
> =20
> +	kfd->profiler_process =3D NULL;
> +	mutex_init(&kfd->profiler_lock);
> +
>  	kfd->num_nodes =3D amdgpu_xcp_get_num_xcp(kfd->adev->xcp_mgr);
> =20
>  	if (kfd->num_nodes =3D=3D 0) {
> @@ -936,9 +939,6 @@ bool kgd2kfd_device_init(struct kfd_dev
> =20
>  	svm_range_set_max_pages(kfd->adev);
> =20
> -	kfd->profiler_process =3D NULL;
> -	mutex_init(&kfd->profiler_lock);
> -
>  	kfd->init_complete =3D true;
>  	dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev->vendor,
>  		 kfd->adev->pdev->device);

Actually, when I test next-20260519 with the improved fix, I do not see
the warning from amdgpu.

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 771fc31a69b8..712316a1e3e0 100644
=2D-- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -269,7 +269,7 @@ static __cold noinline int regen_filesystems_string(vo=
id)
 	hlist_for_each_entry_rcu(p, &file_systems, list) {
 		if (!(p->fs_flags & FS_REQUIRES_DEV))
 			newlen +=3D strlen("nodev");
-		newlen +=3D strlen("\t") + strlen(p->name) +  strlen("\n");
+		newlen +=3D strlen("\t") + strlen(p->name) + strlen("\n");
 	}
 	spin_unlock(&file_systems_lock);
=20
@@ -289,6 +289,7 @@ static __cold noinline int regen_filesystems_string(vo=
id)
 	 * Did someone beat us to it?
 	 */
 	if (old && old->gen =3D=3D file_systems_gen) {
+		spin_unlock(&file_systems_lock);
 		kfree(new);
 		return 0;
 	}
@@ -297,6 +298,7 @@ static __cold noinline int regen_filesystems_string(vo=
id)
 	 * Did the list change in the meantime?
 	 */
 	if (gen !=3D file_systems_gen) {
+		spin_unlock(&file_systems_lock);
 		kfree(new);
 		goto retry;
 	}
@@ -321,13 +323,12 @@ static __cold noinline int regen_filesystems_string(=
void)
 		 * generation above and messes it up.
 		 */
 		spin_unlock(&file_systems_lock);
-		if (old)
-			kfree_rcu(old, rcu);
+		kfree(new);
 		return -EINVAL;
 	}
=20
 	/*
-	 * Paired with consume fence in READ_ONCE() in filesystems_proc_show()
+	 * Paired with consume fence in rcu_dereference() in filesystems_proc_sh=
ow()
 	 */
 	smp_store_release(&file_systems_string, new);
 	spin_unlock(&file_systems_lock);

Bert Karwatzki
