Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EE84ED1BF
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791978256; cv=none; b=VTW0xlEmW1Mn6amwbVjjltm9il23rLWBDiq2Nsk8kOZQBK769t0PTo/1u53m4SqSrYole9IyQMKnXiFCA95/KDhe5KP0yOsWqfgrSnP9b2riABo3yppBGU1tgsxbwrdsrBf7sR1zzfLyjW9fCQIj8x5CMvJ1QE3VCk23oL25ofE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791978256; c=relaxed/simple;
	bh=tfr+1O+Zs6xGsXzFyHpksFrHILj0wxgFMvmKmevytW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=in07ag+G+9opGRg/cWN2Pj5crMN47MexKFfj4IoCAkcSsPn6m4rsP58eJXucTD5D4f1GNG5dbeZeBVBFwaqZ9knasjJEdR3S/mZwdNPf/WIm5Bn7obKgAs/PfRIUfd0ySm7QTJxqSuA9CvGkMd8XK6L9adDD3+cRnQTJUe/DF4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=ahzbqvxY; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="ahzbqvxY"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-33e6279a1d7so322873eec.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 04:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791978253; x=1792583053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kzNB8ZKGHS+H7rhUP5uFFyRM0Y9dLwbgi21LnqDLAyc=;
        b=ahzbqvxYvZzWfNKgShxw+WBH4MGMw9HLNkpdrNTWiZjhI5GPdiJLf/XcBoq4lBg7Wg
         g07uF9EL0fEG7EeJ/tN/RtBgs0lnMrTYmsSDC6VqjocW9FgtqGJacwJkatDj9ByzzcRH
         0qlCkYNwEY9iaPTgO5EWWWdVfLKsP8bA3ooA1AyDc1bEuY/a/mDrx5kwVlCaeRUHanYW
         SYZ/VnZoDlMhjec5OzLS+5S/AUaUlbfQ8ThKlcKn3+ym+8wQSfFsbHqoaBT9fb7la9sS
         /K95/dQr5r/0fUi0mzmq1BALWmErTh5F0E0848Bb8Sp6kLY9gcIMfJ7DRJupsH+Wc7bh
         KH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791978253; x=1792583053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kzNB8ZKGHS+H7rhUP5uFFyRM0Y9dLwbgi21LnqDLAyc=;
        b=OjDDTvEY7h6Cy1ainp2TMPv9Vhuc0mpu4Mx4NAcrK44fd4uaIwnebdt/AP2vQHDcvW
         BzsR0K+VhDhT+H0uUMR8coGk28g0rQx/ecFd/n6E7gCgWhaMxIeXKRU70eAvI8MniHEW
         r2R2SrT2dVvfiMoYka1o0g2yNFWVfEDNmvU660UeaiZwPibX71b4GAFy3z0GWDfjl7t0
         7xciGOf0+elJEnmh9upP8bi7DY9l18ii5CE5nB+X4uiu9GxhVHgxtrANAkkVgPFxnisT
         Bx19prJVQc2A+dKjj7VAU4gCPaySqZrpg8Tqph8eGUMGsnAb8kWsdnGAfXq1JJkuydq9
         mYeQ==
X-Gm-Message-State: AFq9FYLHcC9dI9i3tQxx1w/mn/LiYaFBawGhpI+rQg2wend/5si5lzUa
	Y8Y1I1TMLpOCL91jpKWJzwt8ZGq29+S5wcGwrww+j+qRrexBaBTCrGxEY+yz7qSeSw7PCRgaasS
	Jup/0Ecnn/XQ=
X-Gm-Gg: AYBFou1Ty1zRO5VV98TK+vjzqKO27rIT3Ipfad6ShwNClVvnHCXMDMQJ0AyQS+JOzK6
	fMkXo4qxc1cw20uv/USHR+gCzCiua/8jMR7VMxzUpIF+GvPyQq5JGkqXCsUEE0Dgkeuil0c4IxU
	nEHmJGsG4grFF9iwfjKJjAzDOseWGYRSFWyvdQECCMNUP4lx15oHJPdhojDYGLkj5O4n35UqDHC
	1YR714jlmDZSpJRyqzz83bLRR9URYoveBlPxSJvWb5Oq3RzVqSNtFisXLDGzlp6q9NZpyrvT9PI
	R0kzgq5KTrsKyxkemjeMvUUMFqHf0in4cZCj9GtsvYu6b5pnbm0yGUbzfwKHN1b40F5cb24vnOD
	2nsYKdgn5MmdQwGXrdTvHjBv6G4A5gGL0YCH0SJ8yUZd2J+qd5KI9OZAb0cKM8fit4n/7Xe+4qF
	EUXWNjGAqwtU+hoBSk8gVJp2oQVgxml5K6Lygqmo1HQtUWl9ldVv2PjjpZMRw0slhU1X+Pxoz3d
	V4z6u33TkAX+rw2jls=
X-Received: by 2002:a05:701b:240a:b0:160:8d8e:7e3b with SMTP id a92af1059eb24-16a6169584amr25469415c88.10.1791978252391;
        Wed, 14 Oct 2026 04:44:12 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a442ac67sm71379213c88.18.2026.10.14.04.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:44:11 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	alain@knaff.lu,
	hpa@zytor.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH 0/1] init: distinguish compressed ramdisks from image size
Date: Wed, 14 Oct 2026 19:43:59 +0800
Message-ID: <cover.1791977727.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in init/do_mounts_rd.c. The bug is
reachable by a root user who boots a crafted external initrd with
kexec_file_load().
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

identify_ramdisk_image() uses nblocks == 0 to mark a compressed image.
The same value can result from a malformed legacy filesystem header,
including a SquashFS superblock with bytes_used == 0. In that case no
compression format was detected and decompressor remains NULL.

When the external initrd is preserved as /initrd.image, rd_load_image()
passes that NULL decompressor to crd_load(), which panics with
"Could not decompress initial ramdisk image".

Track compression detection separately from the legacy image block
count. A zero-sized or overflowed legacy image now follows the normal
size validation path, while compressed images retain their existing
handling, including the missing-decompressor diagnostic.

Reproducer:

    chmod +x poc.sh
    ./poc.sh /root/bzImage

The reproducer was run as root in a 2 vCPU, 2 GB x86 QEMU environment.

------BEGIN poc.sh------

    #!/bin/sh
    set -eu

    if [ "$(id -u)" -ne 0 ]; then
    	echo "run as root" >&2
    	exit 1
    fi

    KERNEL_IMAGE="${1:-/root/bzImage}"
    INITRD="/tmp/bad-initrd.bin"
    CMDLINE="root=/dev/sda rw console=ttyS0 quiet loglevel=3 systemd.show_status=false panic=-1 panic_on_warn=0 oops=panic"

    if [ ! -r "$KERNEL_IMAGE" ]; then
    	echo "kernel image not readable: $KERNEL_IMAGE" >&2
    	exit 1
    fi

    python3 - <<'PY'
    from pathlib import Path

    p = Path("/tmp/bad-initrd.bin")
    data = bytearray(4096)
    data[0:4] = b"hsqs"
    p.write_bytes(data)
    PY

    kexec -u || true
    kexec -s -l "$KERNEL_IMAGE" --initrd="$INITRD" --command-line="$CMDLINE"
    kexec -s -e

------END poc.sh--------

----BEGIN crash log----

[    4.114775][    T1] Invalid ramdisk decompression routine.  Select appropriate config option.
[    4.116143][    T1] Kernel panic - not syncing: Could not decompress initial ramdisk image.
[    4.117281][    T1] CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.95 #4 53deed68f5e8c87eac9412ec2ca16e6c37d9fe62
[    4.118753][    T1] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    4.120369][    T1] Call Trace:
[    4.120845][    T1]  <TASK>
[    4.121266][    T1]  panic+0x544/0x620
[    4.121840][    T1]  ? __pfx_panic+0x10/0x10
[    4.122436][    T1]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.123231][    T1]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.123961][    T1]  ? kfree+0x143/0x4a0
[    4.124541][    T1]  rd_load_image+0x970/0xae0
[    4.125192][    T1]  ? __pfx_rd_load_image+0x10/0x10
[    4.125867][    T1]  ? init_mknod+0x16c/0x300
[    4.126499][    T1]  ? kmem_cache_alloc_noprof+0x208/0x3e0
[    4.127230][    T1]  ? __pfx_init_mknod+0x10/0x10
[    4.127881][    T1]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.128618][    T1]  ? __asan_memcpy+0x3c/0x60
[    4.129223][    T1]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.129975][    T1]  initrd_load+0x48/0x350
[    4.130559][    T1]  prepare_namespace+0x8b/0x2d0
[    4.131202][    T1]  ? __pfx_prepare_namespace+0x10/0x10
[    4.131935][    T1]  kernel_init_freeable+0x6d0/0x960
[    4.132634][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.133296][    T1]  kernel_init+0x1f/0x1e0
[    4.133877][    T1]  ? _raw_spin_unlock_irq+0x28/0x40
[    4.134574][    T1]  ret_from_fork+0x31/0x70
[    4.135152][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.135808][    T1]  ret_from_fork_asm+0x1a/0x30
[    4.136505][    T1]  </TASK>
[    4.137158][    T1] Kernel Offset: 0x9000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  init: distinguish compressed ramdisks from image size

 init/do_mounts_rd.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

-- 
2.55.0

