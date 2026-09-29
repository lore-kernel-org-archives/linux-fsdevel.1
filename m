Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814A25392A
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707638; cv=none; b=C5FSw6mayqA+6ZNLHyY2ViNyih3u/vuMjo12cgZcOXYAq8SEwSrDDiVsTZN9yxDd2dpodTugxXdmrHumfV8yhZGldhbTvB9804h298OtScjZGzYoEkkhj77GnzGVckeNBxsNeSU1+to6yryvjAKg1cIgQpUVJNdxWxRX0DZFcQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707638; c=relaxed/simple;
	bh=EkPezjzgyKjDmY8dEhjNwryAYRAXfolM3bFaKogkxiA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BBAfq/20ttDImnNohv3wF6jM9EnSFMXn2fDyslrxE/6hNhkABvI246pTF2Lv8rUSAWDsYWWocNqjRsfmMp68z9JdBmNEp/COdGGnoebNNgTqgKAgzvmPiniPue1AkanBvkasr9+yuB4SO4kLm8EBkOGHJoW+mueDKncxk+QrFZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=lifNGMmr; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="lifNGMmr"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-8a7411012b1so42842407b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 11:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790707635; x=1791312435; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EkPezjzgyKjDmY8dEhjNwryAYRAXfolM3bFaKogkxiA=;
        b=lifNGMmr8uXKlOpM34fhcmL6YZc88QQRjxVI2alLmU2pfDD66jbSWV6MMCsjqlznV9
         LuIEInBgD29LC0DFb3sGu+0lUxQjI2Lewlx88AbSfvUTnv4A7V22VASHxYmOqA272bui
         DpcfQEi0PVYpZcoQa7VjRWBeJQII+Snd+tBtFESwH8BKMwMVpyGGoPmGIYpdmJplGuBG
         ZH1IPil0reWJJxISXGruhjVWdyv+7vBCbXlAGyd/c8RrNw3l2BfuEMXASgu7fq8vEc6p
         UpQNGv7IWAUwyMag/fqG8hiq/wVHrTttybfkbXpc+WbRodNEyuJsBAvylptpGLY2L/0w
         evwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790707635; x=1791312435;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EkPezjzgyKjDmY8dEhjNwryAYRAXfolM3bFaKogkxiA=;
        b=ACSmPIAfcAE2CPjqTj/kwpkl08n6bh1JUuZ0D5dpkHdqT781OBnzJACUYunGRg0njb
         EikbYLNrQ0cogMrOYryfpArlR054MupQeK1csfA/O4S1LfUmDzSyJNpnQLL9tsFdrQHU
         1bpfRk7Rgnboun33Ann1ZiojWyx7AkJuwdFNqGrpqxRb9pQ+woQprZcrYVP2z0LFWSDU
         ToO75Fqsoh9mX+5pp+3xkmlWlCFV2DrbTRamkm/scgQdHoNNruWyZ62zFoQZeStARhqi
         txJWQFMstLOaHIvoSpqeSGf7lLiBOsuhlAq2vtEDJuYbNNbR3AyttEHmxgmizXeLzAfS
         rZKA==
X-Gm-Message-State: AFq9FYJIYPfleEM68ogrt6DhNBf3ssA/9T659Q7LFDp6MU6SoMTRLvz8
	lFD2M24+xNiQhiFP0BlF5OeHQILszkBxNKXxTmMzg9K/waPYCwiEhnkLN9fLTEKLF24c40nwI4R
	KEoTTMtc=
X-Gm-Gg: AYBFou0lPhXgtpihvmjJWJeBuMxuETidJIgp2BOaaC6N3Vwq56T81IfRJbwlVxK5Uql
	m4h4N+gZisBYbOtVG1SVv1cjZAkdLr39M4rr7G5RIz80Rer042ys/3JrwPaPkLVf5uuzNdmGXhC
	GGC7vGdaedrkdx6cujT6636AwGJXTB1uQLSAoOLGh7Z3LuGmzpPn1UD6XW6s95VRTvYWCKJnbBb
	rOv3tkmELh32PR2210IVzpWJzSNEFG3ymfcI3N+7vWVS7wpkIK8SAiE5XoCcNbVn5qZkbuJGDt8
	3xaa/6ySqzkz98lSiRZRLVilvtma3a6HiqxztphHo6f5Z03BaRW4dpEyTtn1dc3WK6djKnPbagR
	V18WtTSqqlA1r2Y25mEfLE0MxwrjPctRw/szoqirmZreHRUxbl5Ht6E6pKgJhvIAmfyeJJfFqhu
	cB7ankuscTEzoPkIwtEwtx1IWSG2BtWPhF/GIR23GTeRN5Mgoajl6Y5wfw1t04/lIKg97JNN7/j
	0licKMQlpP97yJFjxMbYBLdHZKTSUxf1kmZIAzHVjckAo0qx3MUZmh5MJQYvL/c6wXk4+o3CumR
	dAS7OwQYsZqhwz29rpPF4Qb6D2QZKqZmxyfo9endlQiryErzWMRaZhh04DU1Xg==
X-Received: by 2002:a05:690c:7482:b0:8a4:be24:f233 with SMTP id 00721157ae682-8ac1ac83256mr531897b3.46.1790707635314;
        Tue, 29 Sep 2026 11:47:15 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:ace4:86e:1afc:3c4e? ([2600:1700:6476:1430:ace4:86e:1afc:3c4e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8abcea3142esm2103647b3.43.2026.09.29.11.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:47:14 -0700 (PDT)
Message-ID: <debe2b6208864733c943a4d1edb93e54685897c9.camel@dubeyko.com>
Subject: Re: [BUG] hfsplus: nls_utf8 refcount underflow after failed mount
 (6.18.53)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To:
 =?UTF-8?Q?=D0=9C=D0=B0=D1=80=D1=82=D1=8B=D0=BD=D0=B5=D0=BD=D0=BA=D0=BE_?=
 =?UTF-8?Q?=D0=90=D1=80=D1=82=D1=91=D0=BC?=	 <amartynenko140@gmail.com>,
 glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org
Date: Tue, 29 Sep 2026 11:47:11 -0700
In-Reply-To: <9AD67E49-86E9-4508-BBC0-26919C72FB6A@gmail.com>
References: <9AD67E49-86E9-4508-BBC0-26919C72FB6A@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-29 at 15:01 +0300, =D0=9C=D0=B0=D1=80=D1=82=D1=8B=D0=BD=D0=
=B5=D0=BD=D0=BA=D0=BE =D0=90=D1=80=D1=82=D1=91=D0=BC wrote:
> Hi,
>=20
> After a single failed "mount -t hfsplus", the refcount of the
> nls_utf8
> module becomes -1. Afterwards, filesystems that need nls_utf8 fail to
> mount because the NLS table cannot be loaded (seen with hfsplus and
> vfat).
>=20
> System:
> Kernel 6.18.53-0-lts (Alpine linux-lts), Alpine Linux
> 3.25.0_alpha20260805 (edge)
>=20
> Steps to reproduce (right after boot):
>=20
> =C2=A0 modprobe nls_utf8
> =C2=A0 cat /sys/module/nls_utf8/refcnt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 # 0
> =C2=A0 fallocate -l 128M dummy.img
> =C2=A0 mount -t hfsplus dummy.img /mnt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 # fails, as expected (no
> valid HFS+ volume)
> =C2=A0 cat /sys/module/nls_utf8/refcnt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 # -1
>=20
> On a clean boot, a failed mount of the same dummy.img with vfat or
> exfat leaves refcnt at 0; only hfsplus changes it (to -1).
>=20
> dmesg after the failed hfsplus mount:
> [=C2=A0=C2=A0 75.017663] loop0: detected capacity change from 0 to 262144
> [=C2=A0=C2=A0 75.068872] hfsplus: unable to find HFS+ superblock
>=20
> Consequences:
> - The next mount of hfsplus fails with
> =C2=A0 "hfsplus: unable to load nls for utf8".
> - vfat, which uses nls_utf8, also fails to mount:
> =C2=A0 FAT-fs (loop0): utf8 is not a recommended IO charset for FAT
> filesystems, filesystem will be case sensitive!
> =C2=A0 FAT-fs (loop0): IO charset utf8 not found
> - exfat and ext4 still mount fine (they don't seem to use nls_utf8),
> =C2=A0 refcnt stays at -1.
> - "rmmod -f nls_utf8" triggers "kernel BUG at
> kernel/module/main.c:736",
> =C2=A0 after which lsmod hangs.
>=20
> Full oops:
> [ 1480.472851] kernel BUG at kernel/module/main.c:736!
> [ 1480.472860] Oops: invalid opcode: 0000 [#1] SMP NOPTI
> [ 1480.473648] CPU: 1 UID: 0 PID: 2459 Comm: rmmod Tainted: G
> S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.18.53-0-lts #1-Alpine PREEMPT(voluntary)
> [ 1480.474438] Tainted: [S]=3DCPU_OUT_OF_SPEC
> [ 1480.475221] Hardware name: System manufacturer System Product
> Name/P8H61-M LE/USB3, BIOS 3605 03/08/2012
> [ 1480.476019] RIP: 0010:__do_sys_delete_module.isra.0+0x2c2/0x2e0
> [ 1480.476825] Code: a8 48 c7 c7 80 e9 dd a8 e8 eb df 58 00 e9 e8 fe
> ff ff 48 c7 c3 ff ff ff ff e9 41 fe ff ff 48 c7 c3 fc ff ff ff e9 35
> fe ff ff <0f> 0b 48 c7 c3 fe ff ff ff e9 27 fe ff ff e8 bb 06 bf 00
> 66 66 2e
> [ 1480.478556] RSP: 0018:ffffd0c58007bdc0 EFLAGS: 00010297
> [ 1480.479443] RAX: 00000000ffffffff RBX: ffffffffc153b080 RCX:
> 0000000000000000
> [ 1480.480340] RDX: ffffffffc153b548 RSI: 0000000000000000 RDI:
> 0000000000000000
> [ 1480.481234] RBP: 0000559707f5bc70 R08: 0000000000000000 R09:
> 0000000000000000
> [ 1480.482124] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffffd0c58007bf48
> [ 1480.483020] R13: 00000000000000b0 R14: 0000000000000000 R15:
> 0000000000000000
> [ 1480.483921] FS:=C2=A0 00007f9e8a289b28(0000) GS:ffff88c0afc72000(0000)
> knlGS:0000000000000000
> [ 1480.484835] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1480.485750] CR2: 00007f9e8a0d5058 CR3: 0000000102578004 CR4:
> 00000000000626f0
> [ 1480.486679] Call Trace:
> [ 1480.487601]=C2=A0 <TASK>
> [ 1480.488518]=C2=A0 do_syscall_64+0x88/0xd80
> [ 1480.489445]=C2=A0 ? count_memcg_events+0xf9/0x1c0
> [ 1480.490372]=C2=A0 ? handle_mm_fault+0x1e2/0x2e0
> [ 1480.491300]=C2=A0 ? do_user_addr_fault+0x223/0x670
> [ 1480.492225]=C2=A0 ? exc_page_fault+0x7e/0x1b0
> [ 1480.493146]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 1480.494065] RIP: 0033:0x7f9e8a22752a
> [ 1480.494981] Code: e9 e6 32 01 00 48 83 ec 08 b8 af 00 00 00 0f 05
> 48 89 c7 e8 49 eb ff ff 48 83 c4 08 c3 48 83 ec 08 89 f6 b8 b0 00 00
> 00 0f 05 <48> 89 c7 e8 2f eb ff ff 48 83 c4 08 c3 48 83 ec 08 49 89
> ca b8 a5
> [ 1480.496975] RSP: 002b:00007ffdce7a6f90 EFLAGS: 00000206 ORIG_RAX:
> 00000000000000b0
> [ 1480.498007] RAX: ffffffffffffffda RBX: 0000559707f5bc10 RCX:
> 00007f9e8a22752a
> [ 1480.499044] RDX: 0000000000000000 RSI: 0000000000000a00 RDI:
> 0000559707f5bc70
> [ 1480.500078] RBP: 00000000fffffffe R08: 0000000000000000 R09:
> 00007ffdce7a6ff0
> [ 1480.501105] R10: 00000000fffffffe R11: 0000000000000206 R12:
> 0000000000000200
> [ 1480.502134] R13: 0000000000000003 R14: 0000000000000002 R15:
> 0000000000000200
> [ 1480.503171]=C2=A0 </TASK>
> [ 1480.504199] Modules linked in: hfsplus cdrom exfat vfat fat
> nls_utf8 radeon drm_ttm_helper drm_exec drm_suballoc_helper af_packet
> tun fuse snd_hda_codec_alc882 snd_hda_codec_realtek_lib
> snd_hda_codec_generic coretemp intel_rapl_msr intel_rapl_common
> mousedev snd_hda_intel snd_hda_codec x86_pkg_temp_thermal
> intel_powerclamp snd_hda_core kvm_intel iTCO_wdt r8169 intel_pmc_bxt
> snd_intel_dspcfg eeepc_wmi ppdev iTCO_vendor_support kvm asus_wmi
> snd_intel_sdw_acpi realtek snd_hwdep sparse_keymap snd_pcm battery
> irqbypass mdio_devres rfkill psmouse snd_timer ghash_clmulni_intel
> libphy snd mdio_bus rapl intel_cstate serio_raw parport_pc joydev
> soundcore wmi_bmof at24 input_leds pcspkr parport thermal lpc_ich fan
> evdev uas hid_generic usbhid hid i915 drm_buddy ttm hwmon
> i2c_algo_bit drm_display_helper cec intel_gtt video xhci_pci xhci_hcd
> ehci_pci ehci_hcd i2c_i801 i2c_mux i2c_smbus ata_generic pata_acpi
> ata_piix libata button wmi loop ext4 crc16 mbcache jbd2 usb_storage
> usbcore usb_common sd_mod scsi_mod scsi_common
> [ 1480.511897] ---[ end trace 0000000000000000 ]---
>=20
>=20
> Kernel config:
> https://gist.github.com/Artem-coderh/1a88659aad75595b9cadd2f40afee913
> Hardware: ASUS P8H61-M LE, BIOS 3605.
>=20
> I have not tested other kernel versions. I can test patches or bisect
> if needed.


HFS/HFS+ code has a long list of issues. Another bug? OK. What's about
to fix the issue? ;)

Thanks,
Slava.
