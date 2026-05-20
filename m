Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944421A682E;
	Wed, 20 May 2026 22:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779317617; cv=none; b=mQW7wdPfyYySkVHLZWoohV1MCP74TmbrE+Tisjo7xSP0Q9Ow3WV62eiXiYSvdojGdMn4oCNQ+lmwxcCb5V5mGnpFhziVzWJmGx2hqNsBqclWtpgr32uXtjWjzvf6Zrl8DgYJVbCcNQn/Zf+RR3JeasB2KCnblbNaJ4IL2MMxKf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779317617; c=relaxed/simple;
	bh=UDFAzzVqdm/kdipdB9z4iVauG8Oh16mUcfX17LP2qto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BM+A7ocWtKUTvP94Gqpt+yehJwgEl0WTczuMAncuTzk5C+190tqzNcSeuikDBi8Hq/fLJSycX7lSkjkBm+zIKqXJfOLK5AH1kBPWBkNXlMnWRmg69YXJPr2ubTRB2YsHUlOJ4jBufLm/3m/PoZSamiSmMO7aQUudmW7sxr+EQaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=jRA/nlBd; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="jRA/nlBd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1779317567; x=1779922367; i=spasswolf@web.de;
	bh=IwWYEokZaWiKs+dCT6h2LeUkYfQmBC78gtKtdeNusBE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jRA/nlBdMVdArOBIl27Jc6aYz7cfL4QbBkJA9nS1ApSWgyH802BplQLN58uX9MOv
	 /8vK2LhQO+OvH7aobmg1RKQU3pjXYL37GT6xkmK8RsPBwdBhci0QyrF1+lMtAwk87
	 HVGVnaDtnPDvKaQ1Hv/q1PZsp6xgKdmscXyoEkvDThv9YNisfpGBdj58czVN6xYrR
	 zDnWhniCo3Z7BHUvlEVVo1Ifct2QphNRO9gOc0oBx/shOcsHpfy7i4z4fQd61g36Z
	 HPEoPpCIaPGpTVb8nIFiXHMQAtl7lHQ42fmfAcTm0c9BJDz1t9bfiwb0pHuxx60Zs
	 IqGQ+DxoSL0jgY6EhQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJFhJ-1wf10u1fqN-00Jrq6; Thu, 21
 May 2026 00:52:47 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	mjguzik@gmail.com,
	adobriyan@gmail.com,
	jack@suse.cz,
	viro@zeniv.linux.org.uk,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: context switch within RCU read-side critical section in next-20260518+ with PREEMPT_RT
Date: Thu, 21 May 2026 00:52:44 +0200
Message-ID: <20260520225245.2962-1-spasswolf@web.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: 20260425220844.1763933-3-mjguzik@gmail.com
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z+O7qBU6cfTshuykKGyEqRUFHr8Rcq7z1D0NqR+6f4MuDQmYqSF
 1aNQOQ+Nq+X1VpI/IK7rpla5EgXMIhc3JviSKXr/erTknsL2AmHgSg45gV8bbsa9xwbvNLi
 dAhYDxy1ttSW5cyc/3zBzZzvMxxjM7HJeDj56xZRC3jREZGarXIrjoSYKl5HeEP0O109QXI
 Qqlo9drHfoLFGkHLs920Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jS1Ca1t03y0=;pq0rqvVI8DyLCB+7QJ76mgyrCqY
 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

Since version next-20260518 (with PREEMPT_RT) I noticed that my debian stab=
le/trixie system
would sometimes hang when booting displaying the following error message. A=
fter about ~1min
booting continues to a rescue shell where I could save the dmesg output (Th=
e output shown=20
here is not from next-20260519 but from a step in the bisection).

[    2.900440] [    T709] ------------[ cut here ]------------
[    2.900441] [    T709] Voluntary context switch within RCU read-side cri=
tical section!
[    2.900441] [    T709] WARNING: kernel/rcu/tree_plugin.h:332 at rcu_note=
_context_switch+0x2ac/0x460, CPU#4: systemd-fstab-g/709
[    2.900447] [    T709] Modules linked in: efivarfs autofs4 ext4 mbcache =
jbd2 hid_generic usbhid hid amdgpu drm_client_lib i2c_algo_bit drm_buddy dr=
m_ttm_helper ttm drm_exec drm_suballoc_helper mfd_core drm_panel_backlight_=
quirks gpu_sched xhci_pci amdxcp drm_display_helper xhci_hcd drm_kms_helper=
 ahci libahci drm libata usbcore nvme scsi_mod nvme_core igc video i2c_piix=
4 cec nvme_keyring i2c_smbus usb_common scsi_common crc16 nvme_auth wmi gpi=
o_amdpt gpio_generic
[    2.900456] [    T709] CPU: 4 UID: 0 PID: 709 Comm: systemd-fstab-g Not =
tainted 7.1.0-rc4-bisect-02057-g134bedf6b3e5 #452 PREEMPT_RT=20
[    2.900457] [    T709] Hardware name: ASUS System Product Name/ROG STRIX=
 B850-F GAMING WIFI, BIOS 1627 02/05/2026
[    2.900458] [    T709] RIP: 0010:rcu_note_context_switch+0x2ac/0x460
[    2.900459] [    T709] Code: ef e8 58 56 87 00 48 8b 55 28 b9 01 00 00 0=
0 4c 89 ef c6 45 11 00 48 89 c6 e8 e0 99 ff ff e9 cd fd ff ff 48 8d 3d 84 8=
a de 00 <67> 48 0f b9 3a e9 89 fd ff ff a9 a0 20 00 00 0f 85 df 00 00 00 f6
[    2.900460] [    T709] RSP: 0018:ffffb538c1e3fb98 EFLAGS: 00010002
[    2.900461] [    T709] RAX: 0000000000000001 RBX: ffff9bd494a0db00 RCX: =
0000000000000000
[    2.900462] [    T709] RDX: 0000000000000000 RSI: ffffffffb27ad182 RDI: =
ffffffffb2d29400
[    2.900462] [    T709] RBP: ffff9be33f326b00 R08: ffffeba64492bec0 R09: =
ffff9bd491ed1100
[    2.900462] [    T709] R10: 0000000000000001 R11: ffffeba64492bec0 R12: =
0000000000000000
[    2.900462] [    T709] R13: 0000000000000000 R14: ffff9bd494a0db00 R15: =
ffffb538c1e3fcc0
[    2.900463] [    T709] FS:  00007f0367aaf9c0(0000) GS:ffff9be38c475000(0=
000) knlGS:0000000000000000
[    2.900464] [    T709] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.900464] [    T709] CR2: 00007f082baae1d4 CR3: 0000000111ff2000 CR4: =
0000000000f50ef0
[    2.900464] [    T709] PKRU: 55555554
[    2.900465] [    T709] Call Trace:
[    2.900466] [    T709]  <TASK>
[    2.900466] [    T709]  ? __schedule+0x78/0xe50
[    2.900469] [    T709]  ? blk_finish_plug+0x23/0x40
[    2.900472] [    T709]  ? read_pages+0x17f/0x210
[    2.900474] [    T709]  ? schedule+0x22/0xd0
[    2.900475] [    T709]  ? io_schedule+0x41/0x60
[    2.900476] [    T709]  ? folio_wait_bit_common+0x10d/0x2f0
[    2.900477] [    T709]  ? filemap_invalidate_unlock_two+0x40/0x40
[    2.900478] [    T709]  ? filemap_fault+0x7a1/0xfc0
[    2.900479] [    T709]  ? __do_fault+0x30/0x90
[    2.900480] [    T709]  ? do_fault+0x3a9/0x5a0
[    2.900481] [    T709]  ? __handle_mm_fault+0x2c6/0x3a0
[    2.900482] [    T709]  ? handle_mm_fault+0xdc/0x2c0
[    2.900483] [    T709]  ? do_user_addr_fault+0x1e2/0x5f0
[    2.900485] [    T709]  ? exc_page_fault+0x49/0x70
[    2.900486] [    T709]  ? asm_exc_page_fault+0x26/0x30
[    2.900487] [    T709]  </TASK>
[    2.900487] [    T709] ---[ end trace 0000000000000000 ]---

I bisected the error  from v7.1-rc4 to next-20260519, declaring a
commit as GOOD when it survives 12 boots without displaying this error:

7.1.0-rc4-bisect-03214-ge373a2ca9f8f error on 5th boot      BAD
7.1.0-rc4-bisect-01608-gbd4178634082 12 boots without error GOOD
7.1.0-rc4-bisect-02426-g6491cb7030d4 error on 2nd boot	    BAD
7.1.0-rc4-bisect-02025-gd97e5246790d 12 boots without error GOOD
7.1.0-rc1-bisect-00173-gd97d13c24d78 12 boots without error GOOD
7.1.0-rc4-bisect-02116-g44f7bcae0b3d error on 6th boot      BAD
7.1.0-rc4-bisect-00045-g0a8e31d303d5 12 boots without error GOOD
7.0.0-bisect-10592-g2acc3b265f94     12 boots without error GOOD
7.1.0-rc4-bisect-02057-g134bedf6b3e5 error on 1st boot      BAD
7.0.0-bisect-10570-g99bde1dfe878     12 boots without error GOOD
7.0.0-bisect-10616-g5d1aae9252b4     12 boots without error GOOD
7.1.0-rc4-bisect-00003-g24214ad405d1 12 boots without error GOOD
7.1.0-rc4-bisect-02055-g95185f3a36ec error on 4th boot      BAD

This first bisect gives this bogus result:
commit 95185f3a36ec ("Merge branch 'for-next' of https://git.kernel.org/pub=
/scm/linux/kernel/git/hid/hid.git")
which shows there's a false negative in the bisection above.

So I retested some of the commits from above:
7.1.0-rc4-bisect-02025-gd97e5246790d  error on 1st boot (13 boots in total)=
 BAD
7.1.0-rc4-bisect-01608-gbd4178634082  12 boots without error (25 in total) =
GOOD

and started a bisection from bd4178634082 to d97e5246790d (with increased
number of boots required for a good commit)
7.1.0-rc4-bisect-00204-g43467cbc2260  18 boots without error GOOD
7.1.0-rc4-bisect-00333-geda8cb3fb0cb  error on 3rd boot      BAD

With the good and bad commits this close I took a look at
git log --oneline 43467cbc2260..eda8cb3fb0cb
and found exactly one RCU related commit:
dc651e25a6d2 ("fs: RCU-ify filesystems list")

So I reverted the this commit in next-20260519 (to get a clean revert I nee=
ded to
revert commit
36b3306779ea ("fs: cache the string generated by reading /proc/filesystems"=
) first.

$ git log --oneline
c7321982a5d0 (HEAD -> rcu_critical_readside_bug) Revert "fs: RCU-ify filesy=
stems list"
16ff8d6e7c28 Revert "fs: cache the string generated by reading /proc/filesy=
stems"
6a50ba100ace (tag: next-20260519, origin/master, origin/HEAD, master) Add l=
inux-next specific files for 20260519

With these reverts next-20260519 boots 30 times in a row without error, so
it appears that commit dc651e25a6d2 ("fs: RCU-ify filesystems list") causin=
g the
error.

To see if this issue is PREEMPT_RT only I also tested next-20260519 *withou=
t* PREEMPT_RT
and got a different bug at my first boot (the second boot worked, the third=
 failed again)

In the non-RT case there's no rescue shell so this error message is copied =
from a (bad) photo:

[ 2.823291][ T510] BUG: scheduling while atomic: sytemd-hiberna/510
[ 2.824837][ T504] /usr/lib/systemd/system-generators/systemd-hibernate-res=
ume-generator terminated by signal SEGV
BUG: scheduling while atomic: sytemd-hiberna/510
Call Trace:
dump_stack_lvl
__schedule_bug.cold
[...]
asm_exc_page_fault
Code: unable to access opcode bytes at 0x7f243337e216

To see if the non-RT error is caused by the same commit as the RT error I t=
ested
next-20260519 with the reverts and *without* PREEMPT_RT. With the reverts t=
here was
no error in 20 boots. So the problem in the non-RT and RT case seem to be c=
aused by
the same commits.

Hardware used:
$ cat /proc/cpuinfo
processor	: 31
vendor_id	: AuthenticAMD
cpu family	: 26
model		: 68
model name	: AMD Ryzen 9 9950X 16-Core Processor
stepping	: 0
microcode	: 0xb404035
cpu MHz		: 624.194
cache size	: 1024 KB
physical id	: 0
siblings	: 32
core id		: 15
cpu cores	: 16
apicid		: 31
initial apicid	: 31
fpu		: yes
fpu_exception	: yes
cpuid level	: 16
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtsc=
p lm constant_tsc rep_good amd_lbr_v2 nopl xtopology nonstop_tsc cpuid extd=
_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 =
movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_l=
egacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext p=
erfctr_core perfctr_nb bpext perfctr_llc mwaitx cpuid_fault cpb cat_l3 cdp_=
l3 hw_pstate ssbd mba perfmon_v2 ibrs ibpb stibp ibrs_enhanced vmmcall fsgs=
base tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a avx512f avx512dq=
 rdseed adx smap avx512ifma clflushopt clwb avx512cd sha_ni avx512bw avx512=
vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_m=
bm_local user_shstk avx_vnni avx512_bf16 clzero irperf xsaveerptr rdpru wbn=
oinvd cppc arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasi=
d decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif x2avic v_=
spec_ctrl vnmi avx512vbmi umip pku ospke avx512_vbmi2 gfni vaes vpclmulqdq =
avx512_vnni avx512_bitalg avx512_vpopcntdq rdpid bus_lock_detect movdiri mo=
vdir64b overflow_recov succor smca fsrm avx512_vp2intersect flush_l1d amd_l=
br_pmc_freeze
bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass srso spectr=
e_v2_user vmscape
bogomips	: 8599.98
TLB size	: 192 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 48 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

$ lspci -nn
00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Root Complex [1022:14d8]
00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ri=
dge IOMMU [1022:14d9]
00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Dummy Host Bridge [1022:14da]
00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Raphael/Grani=
te Ridge GPP Bridge [1022:14db]
00:01.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Raphael/Grani=
te Ridge GPP Bridge [1022:14db]
00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Dummy Host Bridge [1022:14da]
00:02.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Raphael/Grani=
te Ridge GPP Bridge [1022:14db]
00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Dummy Host Bridge [1022:14da]
00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Dummy Host Bridge [1022:14da]
00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Dummy Host Bridge [1022:14da]
00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Raphael/Grani=
te Ridge Internal GPP Bridge to Bus [C:A] [1022:14dd]
00:08.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Raphael/Grani=
te Ridge Internal GPP Bridge to Bus [C:A] [1022:14dd]
00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controll=
er [1022:790b] (rev 71)
00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridg=
e [1022:790e] (rev 51)
00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Data Fabric; Function 0 [1022:14e0]
00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Data Fabric; Function 1 [1022:14e1]
00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Data Fabric; Function 2 [1022:14e2]
00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Data Fabric; Function 3 [1022:14e3]
00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Data Fabric; Function 4 [1022:14e4]
00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Data Fabric; Function 5 [1022:14e5]
00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Data Fabric; Function 6 [1022:14e6]
00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Gran=
ite Ridge Data Fabric; Function 7 [1022:14e7]
01:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 X=
L Upstream Port of PCI Express Switch [1002:1478] (rev 25)
02:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 X=
L Downstream Port of PCI Express Switch [1002:1479] (rev 25)
03:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD=
/ATI] Navi 44 [RX 9060 XT] [1002:7590] (rev c0)
03:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Navi 48=
 HDMI/DP Audio Controller [1002:ab40]
04:00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co Ltd N=
VMe SSD 9100 PRO [PM9E1] [144d:a810]
05:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series Ch=
ipset PCIe Switch Upstream Port [1022:43f4] (rev 01)
06:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series Ch=
ipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
06:06.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series Ch=
ipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
06:07.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series Ch=
ipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
06:08.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series Ch=
ipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
06:0c.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series Ch=
ipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
06:0d.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series Ch=
ipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
08:00.0 Ethernet controller [0200]: Intel Corporation Ethernet Controller I=
226-V [8086:125c] (rev 06)
09:00.0 Network controller [0280]: MEDIATEK Corp. MT7925 802.11be 160MHz 2x=
2 PCIe Wireless Network Adapter [Filogic 360] [14c3:7925]
0b:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] 800 Serie=
s Chipset USB 3.x XHCI Controller [1022:43fc] (rev 01)
0c:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] 600 Seri=
es Chipset SATA Controller [1022:43f6] (rev 01)
0d:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD=
/ATI] Granite Ridge [Radeon Graphics] [1002:13c0] (rev c1)
0d:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Radeon =
High Definition Audio Controller [Rembrandt/Strix] [1002:1640]
0d:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Fa=
mily 19h PSP/CCP [1022:1649]
0d:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Raphael/G=
ranite Ridge USB 3.1 xHCI [1022:15b6]
0d:00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Raphael/G=
ranite Ridge USB 3.1 xHCI [1022:15b7]
0e:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Raphael/G=
ranite Ridge USB 2.0 xHCI [1022:15b8]

Bert Karwatzki

