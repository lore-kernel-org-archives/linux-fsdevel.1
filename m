Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794703401;
	b=cZFelk/nzFfMMouSqrBKbR1CU/EbJ480/5VZkhfLQn47xKK1lPaDhlAEglhKagPAvF+g
	 qjlt595VpZtcaVNPHWIqhA6aKsSHWREz7Pb0jNgq1lahIR8k61xYwxAAN+/GRIceIIlgJ
	 gFUN5ZlI3xAYmfURxvenwA17H0+JHuqg20imNbkeEgcdBfZlGYm4EzNHRyI4aiFMDgQKl
	 +7aX7NCwTbi/ALpLymNxrFBHiIn5DZZyjr69aQ7MpsD3032TpiWT0Q/1c6oWPo809i0rN
	 eXusvlkTEVZikE/WZeZgButB/sdND/8K/cxfKZOpM0+Ki9ssp7qwtqozy3sJbe1SREg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794703401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=8MMIuK6I3K5vQ1yQIxsPt4KprzePyt/7G+X2OrZOpnQ=;
	b=3qJPCFPGEoJ4zgg6gTG87gJqsh1/epIzFF2GTAns+jgOkKqFVqNYQc0k68sfqu9ec8ha
	 JPQQZdu+BoQ7PIq3dRLccwGK3HaePKwkgkFtVxtN4qMLjkR9Q2M+pg6jBYVW1mPos2oHW
	 aMY4jXtxB8N5Lkat/NriiaxMOEceMfqezmYlbxnbBrpnx2hWxQ+HabthTt67A/x6PG5uA
	 1+fsI9/MZ//nSQNolrow8yJWVDeQXwmk+wzlt/GwRns7AzdG6rJL9GD0QXx22lIjjDSn+
	 b56AIFUfNM+nWrf2k/OX/jifQFSHWZrGKmcVWTV4bxMZEK1buoaEPGlxBnZN33No2mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GBanHfsv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E6F606A323
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 00:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62E6F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GBanHfsv
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3ae25c9f857so27349411fa.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 16:43:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794703399; cv=none;
        d=google.com; s=arc-20260327;
        b=rP4fqXsfd1MupSQrFjIC8xqhuQq9FNWqj2UMhteC/gGPUwGEX6ergWTKL0lFt79MiD
         E6iul8Oo1v52CWdcah20SE6o1cqK984CqDnr+Zb8k3oDNwJ6aJ2TrVuyq00aeGOt5YQ4
         8o0Pv9upMf68hqtjRg+gEGMGflee5D5CvJYoyopyGBhiwBYM4uMAF27koZaRP/Q6ZSkx
         UXsQTVitzSnew5AhZ7zFfJVO7oGuoJq+sQ7oUSt6CPpfun/w5Tp9hkx8NQsJl/OfebcA
         Q9aiNuAcfpUkzzsBii5HoMn9kcGl+iogwjsLBXMsjJ0xqVleplpdabWC6O/5d05hcLF/
         u1xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=8MMIuK6I3K5vQ1yQIxsPt4KprzePyt/7G+X2OrZOpnQ=;
        fh=xdFoM5KLoq7XmH7Te1FJSnvzJ/d+HMRVjv+OYVw4tjY=;
        b=chkLC8FGkH7l6tw0MeLohAnAjdnWLB0W00AIwmZyMjsUvoxYKC+AoR6f9b641dmbeb
         dF45ercIlAmv68n0V7SXTtO9z8NW5N4kY9Fu/8WVNoHH7nu+S/H7JzUBl78XUJ3GR5XC
         v5mPx8CKl0lhewHGdrQ5loz70gb0Ubtoigs/tow33WxxaFJuuqVxuqG6jnDTjkqOsaE8
         TZdLxzOeLcWzVBupC8EHbZgBco3EVKJIT6vf1u7VlXce8OcuNfGW3RhG95sa1xBeMyLD
         LXa4StbtJh1DQhHl9dTQAo1A+sgzJbMMAHTq784lsbIKcjRDCxGHyxv1C4VqR/4npKSV
         llQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794703399; x=1795308199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8MMIuK6I3K5vQ1yQIxsPt4KprzePyt/7G+X2OrZOpnQ=;
        b=GBanHfsvXOqB75slLJE8LsLWchFvISNyGuo4w7xvL7rAq1Lfb/YkB+j77Xmizbu41Q
         NFremmdoli7wbpdX7104B5dQ9vCEaZwX1+oJmpB6en+RDNoaZx7tgHVK664nesAsBeT/
         FE8GIzicPL0PeDBaCruCxHJmoWk4hTkQ/0AnUkY9mB3VR3EzWXHVLgDX+NdTsNcgpIJp
         xNTXUzk6t4/rvSN+jtY19v4CUMy/x+wGLSv/o+DWGR19PYu6P5pm9s789Fu/s43dDoKU
         Vt8ARK/d7emk5S8hRilnLidFiXt9mx/f17g+2XrqS0bWoBWKSnN3LjqXAE2HKo+cgC59
         BIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794703399; x=1795308199;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8MMIuK6I3K5vQ1yQIxsPt4KprzePyt/7G+X2OrZOpnQ=;
        b=sr+dtWsgyRRunLUcrTSbJcwe+JxBaOqGPdZKuZrcignkApHTNERqCJVAZd9a0+Bbhw
         ECabGk4HLRLo2e9na16TQJfE8SgFX1kR3kXRCohN/7i5hRAOYPaggoCowMSsbwT2uQhD
         LEWE7HRxtcSjy9uO6BthK6bkK7HYxmd9zh32gyQHjommMbIHecrGOPrDS2PkaQicfHS6
         CKfSBiMABEaPw/1iExIKVidqUo4gokQT/WMo1/j+xN2Ezwglc4amrRt30atL5OLs95ek
         bTkbyvIwct+oM9P+4E4GIfex314PEm8fBMP4Db/4bTB5DhF5Xanm5TBQNlzomsWAoroi
         sw1g==
X-Forwarded-Encrypted: i=1; AL+hErFwki3U/OCJbxnA6fThCbFxirJTZ4Fb466u1kNuchOI4vYfaAqNmQSCFKl2erLtRzgyzfhx0I2a6mxz0aT+@vger.kernel.org
X-Gm-Message-State: APuU4Z9p8Unf8UYW+Dzs+rWrxGU4i6JRrSyeN2FtOO6pHdSTObLQ+vFi
	BoTbb7pit/Xx8rqrMFK7eTzWqRqxHc0PhBHHUySmf4l/Ce4vTQRMGKnmII5UYk975RgEdP31DxI
	eMn52raUG/5eHq41nBQqie+vg4XiDn7M=
X-Gm-Gg: AYBFou2i1MbqMCARg+tVa9vJFQaw0rK/ljenW4+R8qkqpf2j4I57rty9CeYNk6fNhID
	GQH8AwVi30lIdxrCYyu6q31JVMWcoVrQQvpcDhGZ0GgNBwP2EouwhiGc06G9cXIGg39bzBBVHmX
	KDBnuHk2egfcElGX4ZYhqWVbO+cXfjvFES+rgyFEWPYorHgj6pMaSWI2d2TbD0cYvJIikkdZyu1
	VkTTAw+Or5SddoM0ZmmrGOH6iMAwfQ8bAbikXmysUdklJ1DBz99K5YNzCrIncK05CsqCrH8euWa
	C2OPNEAm9PjHf+/BNTZRi9mejOIvGwqAnrC6MPKww8OLpReDEM7Q4awdTKiRqMOhJYtFH7hiiXf
	JMxvwVN4u48ZzWjfeYZQFMb7ss6irr/c7Yu6SMZFOd5JvnB8IJOMdfPyd94qfPd8q9tiIVTDTZ7
	8DL68Q5r7t2V28T4Xdp7mk3NwpWKNYtVb3yI2zZwNYelZC46aLeZ5laOHUOHfAZOQF7ep4W8r0q
	TU9ow==
X-Received: by 2002:a05:651c:1544:b0:3a8:380c:9fb6 with SMTP id
 38308e7fff4ca-3ae2b6aaccemr21264111fa.28.1794703399262; Sat, 14 Nov 2026
 16:43:19 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Ahmed Khan <ahmadpsn95@gmail.com>
Date: Sat, 14 Nov 2026 19:43:08 -0500
X-Gm-Features: AclHuK8JguVcAUUYQrhGxKWIahEIGkCO11fvzc8h0VRZO67ypHW-NhqDoZkf2P0
Message-ID: <CAOaS1==g3mdoqmS2AjOC0_-woXJbA_X0LJQt7+M7d1=+gfyQqw@mail.gmail.com>
Subject: [BUG] ext4: NULL pointer dereference in jbd2_journal_file_inode()
 during inline data conversion
To: tytso@mit.edu, adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Theodore and Andreas,

My name is Ahmed Khan, I am a security researcher from Canada. I
believe I found a bug within the Linux Kernel, specifically, version
7.3.4 affecting all major distros. I will be candid and state that I
used AI heavily in fuzzing the kernel using "syzkaller". Below are its
findings, the proof of concept worked on my QEMU VM repeatedly.

I found and verified a deterministic NULL pointer dereference in
jbd2_journal_file_inode() triggered when expanding an inline_data ext4
file via path-based truncate() on a filesystem mounted in data=3Dordered
mode.

This corresponds to syzbot crash ID:
3eb9083d961b1b97587d103692546ba06797de4e

1. Root Cause Analysis
----------------------
In ext4, EXT4_I(inode)->jinode is lazily allocated via
ext4_inode_attach_jinode(). Normally this occurs during
ext4_file_open(), ext4_write_begin(), or late inside ext4_setattr().

When path-based truncate() is called on a file without opening a file
descriptor, the inode enters ext4_setattr() with EXT4_I(inode)->jinode
still NULL:

  /* fs/ext4/inode.c =E2=80=94 ext4_setattr() */
  if (ext4_has_inline_data(inode) &&
      attr->ia_size > EXT4_I(inode)->i_inline_size) {
      error =3D ext4_convert_inline_data(inode); /* jinode is still NULL */
      if (error)
          goto err_out;
  }
  ...
  /* ext4_inode_attach_jinode() is only called later in ext4_setattr() */

During inline conversion, ext4_convert_inline_data_nolock() calls
ext4_map_blocks(..., EXT4_GET_BLOCKS_CREATE). When the inode also has
EXT4_INODE_EXTENTS set and the filesystem is mounted with data=3Dordered,
ext4_map_blocks() calls ext4_jbd2_inode_add_write(), passing
EXT4_I(inode)->jinode (NULL) directly to jbd2_journal_file_inode().

jbd2_journal_file_inode() then acquires journal->j_list_lock (with IRQs
disabled) and dereferences the NULL jinode pointer at offset 0x28/0x38,
causing a fatal Oops/GPF while holding the journal list lock.

2. Reproduction Steps
---------------------
1. Mount a crafted ext4 image in default data=3Dordered mode containing a
   regular file with both EXT4_INLINE_DATA_FL and EXT4_EXTENTS_FL set.
2. Without opening a file descriptor on the target file, invoke:
   truncate("./file3", 0x10001);

 * Proof of Concept: Linux Kernel ext4/jbd2 NULL Pointer Dereference
 *
 * Target Linux Kernel Versions:
 *   - Upstream Linux: 7.0 =E2=80=93 7.3.4+
 *   - Confirmed Distro Kernels (6/6 Tested Distros Crashed):
 *       * Ubuntu 26.04.1 LTS (Linux 7.0.0-38-generic #38-Ubuntu)
 *       * Ubuntu 26.10       (Linux 7.3.0-10-generic #10-Ubuntu)
 *       * Fedora Cloud 45    (Linux 7.2.11-300.fc45.x86_64)
 *       * Debian Sid / Forky (Linux 7.2.15+deb14-cloud-amd64)
 *       * Arch Linux         (Linux 7.2.11-arch1-1)
 *       * openSUSE Tumbleweed (Linux 7.3.3-1-default)
 *       * Upstream Base / CachyOS (Linux 7.3.4 SMP KASAN)
 *
 * Vulnerability Summary:
 *   Triggered via truncate("./file3", 0x10001) on a crafted ext4 filesyste=
m
 *   where the target inode has both EXT4_INLINE_DATA_FL and
EXT4_EXTENTS_FL set.
 *   ext4_setattr() calls ext4_convert_inline_data() before attaching a jin=
ode,
 *   causing ext4_jbd2_inode_add_write() to pass jinode =3D=3D NULL into
 *   jbd2_journal_file_inode(), causing an immediate NULL pointer
dereference (GPF)
 *   while holding journal->j_list_lock with interrupts disabled.
 *
 * Crash Signature:
 *   Oops: general protection fault, address: 0x0000000000000028 (or 0x38)
 *   RIP: 0010:jbd2_journal_file_inode+0x14b/0x5b0
 *   note: poc1 exited with irqs disabled / preempt_count 1
 *
 * Compilation:
 *   gcc -O2 -o poc1 poc1_ext4_jbd2_nullderef.c
 *   Prerequisite: ensure /dev/loop0 exists (modprobe loop && losetup -f)
 *
 * Originally autogenerated by syzkaller (https://github.com/google/syzkall=
er)

3. Crash Log (KASAN)
--------------------
[   18.161021] Oops: general protection fault, probably for
non-canonical address
  0xdffffc0000000005: 0000 [#1] SMP KASAN NOPTI
[   18.162724] RIP: 0010:jbd2_journal_file_inode+0x14b/0x5b0
[   18.163481] Code: 48 c1 e8 03 42 80 3c 30 00 74 08 4c 89 e7 e8 4a
41 8c ff 49 8b 44 24 28 ...
[   18.170125] Call Trace:
[   18.170410]  <TASK>
[   18.170685]  ext4_jbd2_inode_add_write+0x138/0x1e0
[   18.171220]  ext4_map_blocks+0x1102/0x1b40
[   18.171691]  ext4_convert_inline_data_nolock+0x18e/0x450
[   18.172281]  ext4_convert_inline_data+0x17c/0x250
[   18.172780]  ext4_setattr+0xa2c/0x1ea0
[   18.173200]  notify_change+0x628/0xd60
[   18.173620]  do_truncate+0x144/0x230
[   18.174020]  do_sys_truncate+0x17e/0x200
[   18.174450]  ksys_truncate+0x2c/0x40
[   18.174820]  do_syscall_64+0x10e/0x5e0
[   18.176450]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   18.178920] note: poc1[318] exited with irqs disabled / preempt_count

4. Suggested Fix Direction
--------------------------
Calling ext4_inode_attach_jinode(inode) inside ext4_convert_inline_data()
(or prior to calling ext4_convert_inline_data() in ext4_setattr())
ensures jinode is allocated before ext4_map_blocks() attempts to add
the inode to the journal's ordered data list.

Please let me know if you would like the standalone C reproducer or
the minimal ext4 disk image attached inline. I have this in a private
repo and would be happy to add you as a project contributor.

Best regards,
Ahmed Khan
