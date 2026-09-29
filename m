Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C104A519DFE
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683315; cv=none; b=lG2beTue8JfLbJwX/U+ZygRd9ITxGmOL9Ae0NbPNMC8XOOOIRo2U9GT0q2MGo/8UQpxH/w0fyHLFjIsalBROSZXV54rDpgGlJlhNZ/JxekhMS+XigYPsya5/NCDI4Pbq2CpthbWtw7YPBlkrDHqqlnJLk4vvt07702mD+VXe3Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683315; c=relaxed/simple;
	bh=4z3WesXtvPEfT3EC6yJHIgFg+44oS4N+21ZtI0C7mDQ=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type; b=Qu1K3kYmV/EaYiDgC2yQGlEBl1LGwYNHu/lYjCwvdxpQGFE2lc84Z6d4LDDavjssdE0TjAwvSu3fuQ8I5INxZ/owcdyq0iEjYrPKaMKQJ5pMbPhbQSR7Ukqhy4eHnEZd8+/6vvoiwDsIaupK/8C1on0M5oag477GOLtj7nGhv0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UutDbD4F; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UutDbD4F"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d3931so31111435e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 05:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790683312; x=1791288112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :user-agent:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JSYB+5afeObNRoom5GcEGYbJu0YT9xClMXnlfklAzYE=;
        b=UutDbD4Frd1QZ4k6W15Br2pOPclGgXO3PuUtASOqGYdX/UyzqCZ7zsEj60x4IOXXPE
         EcClMWEYyCINb29qCsJphuIK1usibHFysr+NMcl5LCLm0Sde4bT3Xe4PKcyn9rw+KoO6
         gS3aJfL4+aFld++0ZFevHSZyMq4n1zwpI2RC5SWsP7emC0fEUuRjxvQi+7jnAID37P+5
         NHWkC7OVHleqNSaS2h+y8TRIpSGb5XJVkFaWoWOCY+uUk2XEGWP3kH+lpbvaLcw/CFTS
         Vup6cOk/E1+9C+Z5wCJTwQEOe/QmgEItfW7yPI870brBdPJh0jdx+wXF5b9QQpkeB3E9
         1+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790683312; x=1791288112;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :user-agent:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JSYB+5afeObNRoom5GcEGYbJu0YT9xClMXnlfklAzYE=;
        b=jy1cZRfh/lh2Qr541tmeXseOYnMI14laABIq2wPqYV0fKk5WX8BbxWfUuZk4ZAjVuN
         ZKNN00r3tQEU01ScQrCEn1UYjHChjAF7R08tl4deXlEvw49Rd8LBiju+cxWEIanpK4l1
         bbMv4ZNUo96GiLm28eEo/v/v2S6LMs3Jrkcm6jz8NX+qhwnn+7IBZ8JEKk9wgDmZhb4B
         K1uLcNALgdjvQ3j/BAScwrRQ7VixK7kcr9aUOzEGV7DRmFyjFjonTPbUzh8m61fhmRZl
         1F+C+g29sM800BaX/iNKL8BxHXw28CWGmfCq3qLZRpjFblPbj1ZjSY5+VCueCPToAHUy
         MKPQ==
X-Gm-Message-State: AFuF++mANyUkjzhOb6o8fChEHQZ9OMWTgJAdn2uZZFFf1d7FwmMirscm
	uI97m20ERWQG9iO5LMh3+0kNg0mDXetYBx3G6QO5/Xt0gZH8itmJqiP5
X-Gm-Gg: AYBFou0JtULjBXCSV8bhg8AQGPW/qHL1Oscd5iVweLixEitOCQK8D7KiN3DFlpsGCtd
	1i2gmAwyTfw1UbiSDNnUqnq71pPHck+q2Ly5kTUXjS8xKwMY8n/WQIGbiRWkWw68wmQWYbR4AdT
	LthmF2yCqr2DPpIZ6kvUq8k2sFjBT7p0laCu/K4eSeSJldCHzhUn4EM3BUiNdbRpjGmpNQB43NZ
	C5GuUx3WV9wi2xPSGzGQ9ulYvJKhGVTQIGW1y22Tq82m0+R9qxh85CUCyvMuJtQZEaeAw5h7xJX
	qqdPzidlxIYRPHjfniEUzufK/6xEKbJRlHH/X37wScybKB/xIX6Aw9cgxPPaP+Vh2TgzuFnEcUn
	asQ9UokRBsiv8xw5C5sBvVQJ1gMm9TtrY/Z+STcVm0nhLAbYJH3+wGGV+LhuhGeZery+A+jOcSe
	Cd1mxCwnBZv3doQ12sqvTVP2N1TFkix10PndibBwyNxBuUE2VBVXXjannCrA5+7Ggw6PHpr1DFI
	b0=
X-Received: by 2002:a05:600c:6290:b0:49e:799a:8969 with SMTP id 5b1f17b1804b1-49fe6707bb7mr300304815e9.30.1790683311594;
        Tue, 29 Sep 2026 05:01:51 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a09:bac1:6180:3380::3a0:3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00d453badsm47098415e9.2.2026.09.29.05.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 05:01:51 -0700 (PDT)
Date: Tue, 29 Sep 2026 15:01:49 +0300
From: =?UTF-8?B?0JzQsNGA0YLRi9C90LXQvdC60L4g0JDRgNGC0ZHQvA==?= <amartynenko140@gmail.com>
To: slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com
CC: linux-fsdevel@vger.kernel.org
Subject: =?US-ASCII?Q?=5BBUG=5D_hfsplus=3A_nls=5Futf8_refcount_un?=
 =?US-ASCII?Q?derflow_after_failed_mount_=286=2E18=2E53=29?=
User-Agent: Thunderbird for Android
Message-ID: <9AD67E49-86E9-4508-BBC0-26919C72FB6A@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

After a single failed "mount -t hfsplus", the refcount of the nls_utf8
module becomes -1=2E Afterwards, filesystems that need nls_utf8 fail to
mount because the NLS table cannot be loaded (seen with hfsplus and
vfat)=2E

System:
Kernel 6=2E18=2E53-0-lts (Alpine linux-lts), Alpine Linux 3=2E25=2E0_alpha=
20260805 (edge)

Steps to reproduce (right after boot):

  modprobe nls_utf8
  cat /sys/module/nls_utf8/refcnt        # 0
  fallocate -l 128M dummy=2Eimg
  mount -t hfsplus dummy=2Eimg /mnt        # fails, as expected (no valid =
HFS+ volume)
  cat /sys/module/nls_utf8/refcnt        # -1

On a clean boot, a failed mount of the same dummy=2Eimg with vfat or
exfat leaves refcnt at 0; only hfsplus changes it (to -1)=2E

dmesg after the failed hfsplus mount:
[   75=2E017663] loop0: detected capacity change from 0 to 262144
[   75=2E068872] hfsplus: unable to find HFS+ superblock

Consequences:
- The next mount of hfsplus fails with
  "hfsplus: unable to load nls for utf8"=2E
- vfat, which uses nls_utf8, also fails to mount:
  FAT-fs (loop0): utf8 is not a recommended IO charset for FAT filesystems=
, filesystem will be case sensitive!
  FAT-fs (loop0): IO charset utf8 not found
- exfat and ext4 still mount fine (they don't seem to use nls_utf8),
  refcnt stays at -1=2E
- "rmmod -f nls_utf8" triggers "kernel BUG at kernel/module/main=2Ec:736",
  after which lsmod hangs=2E

Full oops:
[ 1480=2E472851] kernel BUG at kernel/module/main=2Ec:736!
[ 1480=2E472860] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[ 1480=2E473648] CPU: 1 UID: 0 PID: 2459 Comm: rmmod Tainted: G S         =
         6=2E18=2E53-0-lts #1-Alpine PREEMPT(voluntary)
[ 1480=2E474438] Tainted: [S]=3DCPU_OUT_OF_SPEC
[ 1480=2E475221] Hardware name: System manufacturer System Product Name/P8=
H61-M LE/USB3, BIOS 3605 03/08/2012
[ 1480=2E476019] RIP: 0010:__do_sys_delete_module=2Eisra=2E0+0x2c2/0x2e0
[ 1480=2E476825] Code: a8 48 c7 c7 80 e9 dd a8 e8 eb df 58 00 e9 e8 fe ff =
ff 48 c7 c3 ff ff ff ff e9 41 fe ff ff 48 c7 c3 fc ff ff ff e9 35 fe ff ff =
<0f> 0b 48 c7 c3 fe ff ff ff e9 27 fe ff ff e8 bb 06 bf 00 66 66 2e
[ 1480=2E478556] RSP: 0018:ffffd0c58007bdc0 EFLAGS: 00010297
[ 1480=2E479443] RAX: 00000000ffffffff RBX: ffffffffc153b080 RCX: 00000000=
00000000
[ 1480=2E480340] RDX: ffffffffc153b548 RSI: 0000000000000000 RDI: 00000000=
00000000
[ 1480=2E481234] RBP: 0000559707f5bc70 R08: 0000000000000000 R09: 00000000=
00000000
[ 1480=2E482124] R10: 0000000000000000 R11: 0000000000000000 R12: ffffd0c5=
8007bf48
[ 1480=2E483020] R13: 00000000000000b0 R14: 0000000000000000 R15: 00000000=
00000000
[ 1480=2E483921] FS:  00007f9e8a289b28(0000) GS:ffff88c0afc72000(0000) knl=
GS:0000000000000000
[ 1480=2E484835] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1480=2E485750] CR2: 00007f9e8a0d5058 CR3: 0000000102578004 CR4: 00000000=
000626f0
[ 1480=2E486679] Call Trace:
[ 1480=2E487601]  <TASK>
[ 1480=2E488518]  do_syscall_64+0x88/0xd80
[ 1480=2E489445]  ? count_memcg_events+0xf9/0x1c0
[ 1480=2E490372]  ? handle_mm_fault+0x1e2/0x2e0
[ 1480=2E491300]  ? do_user_addr_fault+0x223/0x670
[ 1480=2E492225]  ? exc_page_fault+0x7e/0x1b0
[ 1480=2E493146]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1480=2E494065] RIP: 0033:0x7f9e8a22752a
[ 1480=2E494981] Code: e9 e6 32 01 00 48 83 ec 08 b8 af 00 00 00 0f 05 48 =
89 c7 e8 49 eb ff ff 48 83 c4 08 c3 48 83 ec 08 89 f6 b8 b0 00 00 00 0f 05 =
<48> 89 c7 e8 2f eb ff ff 48 83 c4 08 c3 48 83 ec 08 49 89 ca b8 a5
[ 1480=2E496975] RSP: 002b:00007ffdce7a6f90 EFLAGS: 00000206 ORIG_RAX: 000=
00000000000b0
[ 1480=2E498007] RAX: ffffffffffffffda RBX: 0000559707f5bc10 RCX: 00007f9e=
8a22752a
[ 1480=2E499044] RDX: 0000000000000000 RSI: 0000000000000a00 RDI: 00005597=
07f5bc70
[ 1480=2E500078] RBP: 00000000fffffffe R08: 0000000000000000 R09: 00007ffd=
ce7a6ff0
[ 1480=2E501105] R10: 00000000fffffffe R11: 0000000000000206 R12: 00000000=
00000200
[ 1480=2E502134] R13: 0000000000000003 R14: 0000000000000002 R15: 00000000=
00000200
[ 1480=2E503171]  </TASK>
[ 1480=2E504199] Modules linked in: hfsplus cdrom exfat vfat fat nls_utf8 =
radeon drm_ttm_helper drm_exec drm_suballoc_helper af_packet tun fuse snd_h=
da_codec_alc882 snd_hda_codec_realtek_lib snd_hda_codec_generic coretemp in=
tel_rapl_msr intel_rapl_common mousedev snd_hda_intel snd_hda_codec x86_pkg=
_temp_thermal intel_powerclamp snd_hda_core kvm_intel iTCO_wdt r8169 intel_=
pmc_bxt snd_intel_dspcfg eeepc_wmi ppdev iTCO_vendor_support kvm asus_wmi s=
nd_intel_sdw_acpi realtek snd_hwdep sparse_keymap snd_pcm battery irqbypass=
 mdio_devres rfkill psmouse snd_timer ghash_clmulni_intel libphy snd mdio_b=
us rapl intel_cstate serio_raw parport_pc joydev soundcore wmi_bmof at24 in=
put_leds pcspkr parport thermal lpc_ich fan evdev uas hid_generic usbhid hi=
d i915 drm_buddy ttm hwmon i2c_algo_bit drm_display_helper cec intel_gtt vi=
deo xhci_pci xhci_hcd ehci_pci ehci_hcd i2c_i801 i2c_mux i2c_smbus ata_gene=
ric pata_acpi ata_piix libata button wmi loop ext4 crc16 mbcache jbd2 usb_s=
torage usbcore usb_common sd_mod scsi_mod scsi_common
[ 1480=2E511897] ---[ end trace 0000000000000000 ]---


Kernel config: https://gist=2Egithub=2Ecom/Artem-coderh/1a88659aad75595b9c=
add2f40afee913
Hardware: ASUS P8H61-M LE, BIOS 3605=2E

I have not tested other kernel versions=2E I can test patches or bisect
if needed=2E

Thanks,
Artem Martynenko
