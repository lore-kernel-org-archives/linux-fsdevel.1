Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265308;
	b=IHLhIWRbQUds5yb//+etMEeIeCb4T4+6xndIyPB3kXCaznV28PNAJwvN8jR/g1GlJSK/
	 LW7ODucrHlUWC6rGTcRISw3t/QlHfgA3CjLf1uD0GOVD8k8LZ6PJUtf4qwdoNF713wP9U
	 QVYsZ1q67FQ1DOPWUROYzKRP0QUEzX8ktwcS8//wmxA64sXjRcqTLNh4R9r7CuS+a7Cy7
	 m0hhz/6HY0fDqlF3T2NBr1L20Mq9eL9RiaN0gOrguu5BdM4cVosJWlFRwbk7p0lGw4rpF
	 ykAEnlFjEEVHWpl7TaG5T0fw/3VEOSilgw+W+/Q6ie5DBkRCZLnH1IoX6+qM3yPGxJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265308;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Mx22REzFeEEOIRXMuOyiOrU/x+miQ5KmMLlEjaE5lfc=;
	b=1lYTbI7xeeH6D4si08GgaekVp1C42iKp2K8ffYjZGblCj+1Q4N3n0NM5CAEfKI0VKtGT
	 eNmJGCObUuRHXIPold61iRknpxs5CCQpIY7L2oIQzleYrPh06Swn0ntrL0It7bK5Hncj1
	 OofXwx2pZFdOdVv9FnREvwuVqQc2iGlMlBT1lvTzIYpzfZ0IIQma6H69jlXY1iA3K3VJn
	 1E0mmSRtVIY26DMgpqQ0DSfjMVMjsVZcUXr/3fMCFUvLJcxJs7cBtYvrlF1oQjSr2ROid
	 OrhMfNzjPiRZsP4r+bI7mo8SDwBFsfJMj7YM5mZqkt1fQqxl4ubf8X2CK7BT++PLl/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ON6GeO1E;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AE0606A320;
	Thu, 29 Oct 2026 09:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29AE0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ON6GeO1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Mx
	22REzFeEEOIRXMuOyiOrU/x+miQ5KmMLlEjaE5lfc=; b=ON6GeO1ElTnnw34Rjl
	IDIFYQhvRcb8rlxqP35FJV6I2EbcfPwDmaQIs1nQAWAjXeZWHkxosq/kHsLP7/Ey
	j6oMTCb4lFcl5fDlLN8Buq9xlcJrtLRNLXIZ3d5R6635/PwchENNi7c8va1dLT4t
	iNrxSQfE7tcgCGPRws0YXu8+0=
Received: from shaos.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnr0qDDuNqgUQvCw--.22693S2;
	Thu, 29 Oct 2026 17:14:43 +0800 (CST)
From: shaos <shawnq1@163.com>
To: brauner@kernel.org,
	aliamemis@disroot.org
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nls: fix ISO-8859-14 case folding
Date: Thu, 29 Oct 2026 09:14:43 +0000
Message-Id: <20261029091443.3531919-1-shawnq1@163.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnr0qDDuNqgUQvCw--.22693S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF4UJF47ZrykWr4xWryxAFb_yoWrGryfp3
	s5Xw48Jwn5tF10yr929F1rGFy8ursrAw45Cw4kW395u3Z3Grs5tFyakrWjgF1q9r1kCay3
	ZF4FqF1Sqa18Xr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UdpnLUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC8QU4RmrjDoXC0wAA3Z

Hello,

The ISO-8859-14 charset2lower table maps byte 0xa4 (U+010A) to 0xab,
the lowercase byte for U+1E0A. VFAT uses this table for its default
case-insensitive lookup, so a lookup for the distinct, absent byte
0xa4 can open a file displayed by readdir() as 0xa6.

The PoC mounts a small VFAT image with iocharset=iso8859-14 and
uni_xlate=1, creates only :1e0a, and then looks up byte 0xa4. On the
unmodified kernel, readdir() lists 0xa6 while stat(0xa4) succeeds and
returns the created file. Remounting with check=s makes 0xa4 return
ENOENT. The issue is in charset2lower[] and is independent of the
page01/page1e conversion-table fix in 8e17b922aff0.

git tree:       upstream torvalds/linux master
source version: Linux 7.3.0-17714-gc339f4010dea
architecture:   x86-64
compiler:       gcc 11.4.0, GNU ld 2.38
QEMU:           6.2.0

console output:
https://gist.githubusercontent.com/shaos26/4115e33780bb1ea2a0e042aa6e6588da/raw/9dfb43bd1f99e1d9138cf8147fe29eb0f131978b/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/4115e33780bb1ea2a0e042aa6e6588da/raw/7481bf507133c8dcb3549ed04ef4abe8de69cd48/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/4115e33780bb1ea2a0e042aa6e6588da/raw/54bd8643014abaaa49a24cbc7ff8c93329dd62b6/poc.c

Build the kernel from HEAD with the attached config, then build the
PoC and initramfs:

    mkdir -p build rootfs/dev rootfs/mnt rootfs/proc rootfs/sys
    cp kernel-config.txt build/.config
    make O=build olddefconfig
    make O=build -j"$(nproc)" bzImage
    gcc -O2 -static -Wall -Wextra -o reproducer poc.c
    cp reproducer rootfs/init
    (cd rootfs && find . -print0 | cpio --null -o -H newc | \
        gzip -9n) > initramfs.cpio.gz
    truncate -s 32M fat.img
    mkfs.vfat -F 16 fat.img

Run the guest with:

    timeout 120s qemu-system-x86_64 -machine q35 \
        -accel tcg,thread=multi -cpu max -smp 1 -m 2048 \
        -kernel build/arch/x86/boot/bzImage \
        -initrd initramfs.cpio.gz \
        -append "console=ttyS0 rdinit=/init" \
        -drive file=fat.img,format=raw,if=virtio,snapshot=on \
        -display none -serial stdio -monitor none -no-reboot

The same PoC prints RESULT: VULNERABLE on the original tree and
RESULT: FIXED after the change below. In both cases, the check=s control
returns ENOENT for 0xa4 while byte 0xa6 remains accessible. Mounting
VFAT requires the privilege needed to mount a filesystem. This report
demonstrates filename lookup confusion, not privilege escalation or
memory corruption.

Link: https://lore.kernel.org/20260909121032.76647-1-aliamemis@disroot.org
Signed-off-by: shaos <shawnq1@163.com>
---

Validation: Fresh QEMU runs on unmodified c339f401 and on the patched
kernel, both with one vCPU and the same configuration, printed
RESULT: VULNERABLE and RESULT: FIXED respectively.
scripts/checkpatch.pl --no-tree --strict reports no errors or warnings,
and git apply --check succeeds.

diff --git a/fs/nls/nls_iso8859-14.c b/fs/nls/nls_iso8859-14.c
index 60b9400f915af..c9bc4e0d30603 100644
--- a/fs/nls/nls_iso8859-14.c
+++ b/fs/nls/nls_iso8859-14.c
@@ -240,7 +240,7 @@ static const unsigned char charset2lower[256] = {
 	0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f, /* 0x88-0x8f */
 	0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, /* 0x90-0x97 */
 	0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f, /* 0x98-0x9f */
-	0xa0, 0xa2, 0xa2, 0xa3, 0xab, 0xab, 0xab, 0xa7, /* 0xa0-0xa7 */
+	0xa0, 0xa2, 0xa2, 0xa3, 0xa5, 0xa5, 0xab, 0xa7, /* 0xa0-0xa7 */
 	0xb8, 0xa9, 0xba, 0xab, 0xbc, 0xad, 0xae, 0xff, /* 0xa8-0xaf */
 	0xb1, 0xb1, 0xb3, 0xb3, 0xb5, 0xb5, 0xb6, 0xb9, /* 0xb0-0xb7 */
 	0xb8, 0xb9, 0xba, 0xbf, 0xbc, 0xbe, 0xbe, 0xbf, /* 0xb8-0xbf */
Thanks,

shaos

