Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5615638239A;
	Thu, 21 May 2026 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358640; cv=none; b=hWSBWF4WKDIt7YzhrmqYbpdnM+U5ERwlgkfJV+8yLy+CImjBBqvqnRQ13rto7Uo3fvW46afuKCi0o88jE0OvfxSHposYzfPy9nCYOOzem8hWSawWviTuVGpHq/8Ff8susshAgVupfgXhvc0DsvxgMwTxvUBRsgiFMS6TO+k3yb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358640; c=relaxed/simple;
	bh=mD3J/wrJlQBpJSLK1+OqzANAyjKJc4lP3+bdss5zTFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AxDJ52SaTMP6+2I0ywSmwEIDGh88mXOuD7Ny1FAcrAjFg4Gs2EXLpVO86aCMOwOKACZxnef4U73M/Wkoj0oIbTgii/+tQgtjkMpL5ycTyduolbC0jzV5vFxMfcoDI9e2yMchiAETwZWRgRus1I28J2A4iAn+n78iGZAwbdtpcsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wCmBEW1c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B69uRIZi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wCmBEW1c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B69uRIZi"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779358636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1jaC8pjc2z4shGVJq80mW2Jzm/K/JIWXN2kFb0V3uLE=;
	b=wCmBEW1csGgo6syobkpdDxC06y1HG3kmdpdwRa7DPH6YN3kLFOKcXzONgSjBXgCy6yROAt
	qlctch6ry6QKTLAheqPRS7R9uedTa0jbPO48CqBpT3sabRfDooKu7/UuzNPCWLzFMBF1/n
	gJwYwKVqdGCHUNAikWnpQ+LmdBbrwzk2YEQX7zZGx8TG2TT7nRa5eS5DrJE3k9lhOqhsj3
	ZWHhh4Ypbp6x/NNZPav7ErpZJYYsWtt40ZCemDfwP59b2RtE1EnM1vcke1c6FIDVepvx7L
	HXfRYznstV7o8y43sAB+FbqSXIeVh2ToV8lhAv7PjtT+Cz93UlyF1gtVaYm6RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779358636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1jaC8pjc2z4shGVJq80mW2Jzm/K/JIWXN2kFb0V3uLE=;
	b=B69uRIZih19kZU6rGQuO8trjDRjaUnObUsVeWvr8Dpgj+TIqFZqKqasDfd7vrhcGgcVlf5
	5+3QMR9ik045RyBA==
To: Bert Karwatzki <spasswolf@web.de>, Mateusz Guzik <mjguzik@gmail.com>,
 Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 adobriyan@gmail.com, jack@suse.cz, viro@zeniv.linux.org.uk, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, spasswolf@web.de, Alex Deucher
 <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
In-Reply-To: <4f548d61b2dd12e01f401ce4b8c865f238f7b23c.camel@web.de>
References: <20260520225245.2962-1-spasswolf@web.de>
 <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
 <s7cu3dpioidx6mepmai6eyj2pxjs4skbw7v534zbzs6g2fwcis@cvokidcxy3xa>
 <4f548d61b2dd12e01f401ce4b8c865f238f7b23c.camel@web.de>
Date: Thu, 21 May 2026 12:17:15 +0200
Message-ID: <878q9dvzh0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 21 2026 at 11:20, Bert Karwatzki wrote:
> Am Donnerstag, dem 21.05.2026 um 11:09 +0200 schrieb Mateusz Guzik:
>
> with next-20260519 (no RT, no LOCKDEP) and got no crash so far (4 boots only though (next-20260619
> crashed in 2 out of 3 boots without RT)) but I get this warning on every boot:
>
> [    2.793416] [    T331] ------------[ cut here ]------------
> [    2.793433] [    T331] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
> [    2.793434] [    T331] WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0x586/0x10c0, CPU#17: (udev-worker)/331

So either the mutex is corrupted or was never initialized.

> [    2.793463] [    T331] Modules linked in: amdgpu(+) hid_generic usbhid drm_client_lib i2c_algo_bit drm_buddy hid drm_ttm_helper ttm drm_exec
> drm_suballoc_helper mfd_core drm_panel_backlight_quirks gpu_sched amdxcp drm_display_helper drm_kms_helper ahci libahci xhci_pci libata xhci_hcd drm nvme
> scsi_mod igc usbcore nvme_core scsi_common video nvme_keyring i2c_piix4 cec nvme_auth usb_common crc16 i2c_smbus wmi gpio_amdpt gpio_generic
> [    2.793518] [    T331] CPU: 17 UID: 0 PID: 331 Comm: (udev-worker) Not tainted 7.1.0-rc4-next-20260519-rcunortlockdep-dirty #465 PREEMPT 
> [    2.793534] [    T331] Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI, BIOS 1627 02/05/2026
> [    2.793547] [    T331] RIP: 0010:__mutex_lock+0x58d/0x10c0
> [    2.793555] [    T331] Code: 4c 8b 4d 88 85 c0 0f 84 f8 fa ff ff 44 8b 15 ca 9b 81 00 45 85 d2 0f 85 e8 fa ff ff 48 8d 3d 1a 57 82 00 48 c7 c6 a6 51 9e 83
> <67> 48 0f b9 3a 4c 8b 4d 88 e9 cc fa ff ff 48 8b bd 78 ff ff ff e8
> [    2.793579] [    T331] RSP: 0018:ffffa497016c3510 EFLAGS: 00010246
> [    2.793588] [    T331] RAX: 0000000000000001 RBX: ffff88c33a4c2ad8 RCX: 0000000000000000
> [    2.793598] [    T331] RDX: 0000000000000001 RSI: ffffffff839e51a6 RDI: ffffffff83de3c00
> [    2.793609] [    T331] RBP: ffffa497016c35c0 R08: ffffffffc0a55d92 R09: 0000000000000000
> [    2.793619] [    T331] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [    2.793629] [    T331] R13: 0000000000000002 R14: ffffa497016c3550 R15: 0000000000268000
> [    2.793641] [    T331] FS:  00007f1f32e5b9c0(0000) GS:ffff88d23b2ca000(0000) knlGS:0000000000000000
> [    2.793653] [    T331] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.793662] [    T331] CR2: 000055cdfa28f588 CR3: 0000000112e73000 CR4: 0000000000f50ef0
> [    2.793673] [    T331] PKRU: 55555554
> [    2.793678] [    T331] Call Trace:
> [    2.793683] [    T331]  <TASK>
> [    2.793687] [    T331]  ? lock_acquire+0xbe/0x2d0
> [    2.793696] [    T331]  ? init_mqd+0x122/0x190 [amdgpu]
> [    2.793809] [    T331]  ? lock_release+0xc6/0x2a0
> [    2.793816] [    T331]  ? init_mqd+0x122/0x190 [amdgpu]
> [    2.793902] [    T331]  init_mqd+0x122/0x190 [amdgpu]
> [    2.793961] [    T331]  init_mqd_hiq+0xd/0x20 [amdgpu]
> [    2.794015] [    T331]  kq_initialize.constprop.0+0x2b8/0x370 [amdgpu]
> [    2.794071] [    T331]  kernel_queue_init+0x3f/0x60 [amdgpu]
> [    2.794125] [    T331]  pm_init+0x6b/0x100 [amdgpu]
> [    2.794178] [    T331]  start_cpsch+0x1d6/0x270 [amdgpu]
> [    2.794234] [    T331]  kgd2kfd_device_init.cold+0x7b9/0xa1a [amdgpu]
> [    2.794365] [    T331]  amdgpu_amdkfd_device_init+0x190/0x260 [amdgpu]

amdgpu_amdkfd_device_init()
  kgd2kfd_device_init() {
      ....
        init_mqd()
          mutex_lock(... profiler_lock); <- FAIL

      mutex_init(...profiler_lock);
  }

Seems the famous graphics CI failed to catch this...

Thanks,

        tglx
---
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -744,6 +744,9 @@ bool kgd2kfd_device_init(struct kfd_dev
 			KGD_ENGINE_SDMA1);
 	kfd->shared_resources = *gpu_resources;
 
+	kfd->profiler_process = NULL;
+	mutex_init(&kfd->profiler_lock);
+
 	kfd->num_nodes = amdgpu_xcp_get_num_xcp(kfd->adev->xcp_mgr);
 
 	if (kfd->num_nodes == 0) {
@@ -936,9 +939,6 @@ bool kgd2kfd_device_init(struct kfd_dev
 
 	svm_range_set_max_pages(kfd->adev);
 
-	kfd->profiler_process = NULL;
-	mutex_init(&kfd->profiler_lock);
-
 	kfd->init_complete = true;
 	dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev->vendor,
 		 kfd->adev->pdev->device);
