Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.121.53.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440686;
	b=J5q9NeVPsZwkhJMsjN+mQOTBeFkfU+HFaee9VZHZUlhnu+l3ahY91NetGg0RJkNi0NcA
	 vtpfezUhrw2RsnvOf619iC8JVRjAlNUPvSu22Dt+Go5m2XC++Smw9xhDrW7fxXdRxX+fv
	 +wPJUrjU45lMCvwD7Xj7w5tGjm5VYLdZcB8xCWJM1ggYTMxDId5tGoochr3nIU03doALN
	 YtrIEoEZ+02VhfQf7OZPwxoikMz7iXg3R2dJWWRUjBp5kJShc8f3KMfJALhLTP8PWLWd+
	 llQHLJuuj7cWTZXmxF4WG/RumqCKOrL8Obh0UCN/Le0M1wxu164RANm8oFx6h+GVqMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440686;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:X-CMAE-Analysis:
	 Feedback-ID:X-SECURESERVER-ACCT:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CMAE-Envelope;
	bh=9mpNqi3BPRqe77241RQLFFs9gDrPAE9CjtKiMRD98PY=;
	b=Eys/NT67wrcASR33vLUdax3BSaAaGYUOXDgr082RW6TM2o0GadfySENtQoJO/GVEQWqs
	 OQX8pkM5gvDw7R8FYu016iKRDNpFsuVmSKobT6uyFGBs+I84WUxrrl5M69x/19ujg3Yxi
	 ej/xS4bitMhEVFm6A9HpMpYcB8IJoMuaSOEJMsxJlPcUAwZbsu5pwTdktgT7+6jw5GmXN
	 NtRFAYZXK7QbRarV539rEFEDtWIIxItU47is2Jt8FtCXoo+w+IFIwR4R1xRxmWJvn49Cx
	 TVK0kx6fl2DLiLDXFKJ0FbPxdKQ9x7Udz3Db93Z0izFJhhziJ2PCSE81B/FsGWRrU+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squashfs.org.uk;
	spf=pass smtp.mailfrom=squashfs.org.uk;
	dkim=pass header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=ZLFbGj0G;
	dkim=pass header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=meMnq7mN;
	arc=none smtp.remote-ip=188.121.53.25
Received: from sxplsmtpa04-03.prod.sxb1.secureserver.net (sxplsmtpa04-03.prod.sxb1.secureserver.net [188.121.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FC1606A88D
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 23:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2FC1606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=ZLFbGj0G;
	dkim=pass (2048-bit key, unprotected) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=meMnq7mN
Received: from avalon.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id RHz6xtxIpLwCURHzaxAFYI; Wed, 11 Nov 2026 23:44:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1794440679;
	bh=9mpNqi3BPRqe77241RQLFFs9gDrPAE9CjtKiMRD98PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZLFbGj0GV5dUsCCDL8fnlJMUjioCFXo+JKbOAvXBU5g0Hge4oBFGTxQi6HYS5j4DF
	 2UV9jNrnnZ/GDRkQwcSbmF8KLwbay16hRFTXkSFvNKGB0bj3uDRltemLCTF/PPZTGv
	 Y9/FAFyA8vHhGeFqHNNmVmNTp2dBUuM0PxLVMermLeXdVyAvsCyNA15dqWRqPHjjeH
	 jkj1O9ul6s3PkzKkizJ2PejAyxkzT93xbXsPNEe2B0K5KmLv59PWUxKC1OEmmSxauW
	 G+Ewvukg5qnJthCuWWfyp7saBg0Ro+Q56DWysbkTe84IlXH6UWe8DslRjJhrqFpLXP
	 uF8YXEMYcy+NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver1; t=1794440679;
	bh=9mpNqi3BPRqe77241RQLFFs9gDrPAE9CjtKiMRD98PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=meMnq7mNDmbFatA4iKKz0JCMWIu3plP9laupNhY1R4CSkaAhO8dGHoYy4PwMhnNiH
	 F2AETYbNFXyq0NJsrGIC1QnVZkSPvUNgJFRA+fT4Ati6SUxKH7CuMOPN6gcKjALVly
	 C7gOjopMqJRxYp/970yoTCUYRbjzHdBVeEh15fPocP92nF9VBR+eaaZK0D+J/m6qBt
	 7mffr6SS/Pfca0F062JPYlDfIAZJPNGHE8Q2iuh9ykZT3zAk8xzTEXnJInETOLOOqB
	 AvxJenv0dqmJMlyaabVT4aTzfiEues6J4mSleErZO48MeI3Rtrc2PrqP0WaA83rGjg
	 84NMIn2ZT6JMg==
X-CMAE-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6af4fde7
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=yKgdCBhA7QK4Y9OD5tEA:9 a=UObqyxdv-6Yh2QiB9mM_:22
Feedback-ID: dcbe18cc3445f74f08dc34f5446b42fd:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH v2 08/22] Squashfs: fix fragment bytes overflow on 32-bit architectures
Date: Wed, 11 Nov 2026 23:43:48 +0000
Message-ID: <20261111234402.252354-9-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111234402.252354-1-phillip@squashfs.org.uk>
References: <20261111234402.252354-1-phillip@squashfs.org.uk>
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
X-CMAE-Envelope: MS4xfDp6Wwyfy29E+SxpZzn1UnkIZwvNcGMr6wxgDmvn9jBU6BIXBwB7BPImhaydz2kQOsbDT48h/pibyc3Qjv56IQ7ysxE1qsXSPeV+ZS5ZFLzmQphVrIT6
 cyW8gqsI5xxujTDBbWHvLE4GtYMQeCutimca+VGUhWzRlkQ2Rd/DxeWawcXSvQcZbrNuOEcmWBH0fa1kQBa74RdrJyNN38D2zAMGF3XLuuMpuqhkOCv1BfzR
 1QGwC6gA/6fKznOIDbtwDaD90kd9hSj+P4FsaKx1Py8zvtgAAR/ywGm0u6J4f+h2WqCQHEOHxTW8yEheut/Kr6TQGnCA+d2fwokDRC8rWI0=

In helper function squashfs_fragment_bytes() the u32 fragments
variable is multiplied by sizeof(struct squashfs_fragment_enty).

On a 32-bit architecture the type of sizeof() is a 32-bit unsigned
integer, which means the computation will overflow for fragments
values above 268435455.

The knock-on effect is the size of the in memory fragment index
table will be incorrectly computed, and a much smaller than expected
index table will be allocated and read into memory.

Later when a fragment index beyond this is looked up in this table,
this will produce an out of bounds access.

The fix is to explicitly widen the fragments variable to a long long
in the squashfs_fragment_bytes() helper function.

Reproducer
=========

The following script when run on a 32-bit x86 kernel (which lacks
KASAN support) will produce an I/O error.  On a 32-bit ARM kernel
with KASAN enabled, the out of bounds access will also produce a
KASAN report.

[  193.817260] ==================================================================
[  193.818057] BUG: KASAN: slab-out-of-bounds in squashfs_frag_lookup+0x23c/0x264
[  193.820408] Read of size 8 at addr cc126708 by task stat/357
[  193.820720]
[  193.821675] CPU: 3 UID: 0 PID: 357 Comm: stat Not tainted 7.2.0-13187-g66498c75b4f8 #113 VOLUNTARY

=================================================================
#!/bin/bash

ARGS="-no-duplicates -no-sparse -no-hardlinks -quiet -no-progress"

finish() {
	popd 2>&1 > /dev/null
	rm -rf $DIR
	exit 1
}

# Create a Squashfs filesystem with 1026 files and 513 fragments.
# This will create a two entry Squashfs fragment index table.
#
DIR=$(mktemp -d)

pushd $DIR 2>&1 > /dev/null

# Create a Squashfs pseudo file which is fed to Mksquashfs
echo Create a Squashfs pseudo file which is fed to Mksquashfs

dd if=/dev/urandom of=urandom bs=1024 count=50 status=none
for i in $(seq 1 1026); do
	echo "$i l urandom" >> pseudo
done

# Create the Squashfs filesystem
echo Create the Squashfs filesystem

if ! mksquashfs - img.sqsh -pf pseudo -p "/ d 0777 0 0" $ARGS; then
	echo Failed to create Squashfs filesystem
	finish

fi

# The fragments field (fragment count) in the superblock is at offset
# 16 bytes.
#
# Over-write the fragments count with 268,435,457 little-endian.  On a
# 32-bit architecture, this when multiplied by 16 will overflow, giving
# the value 16.
#
# Ultimately this will cause the kernel code to create and read a single
# entry index table (where in fact the table has two entries).
#
# Then stating file 999 which has a fragment id in the second index,
# will cause an out of bounds access.

# Write 268,435,457 in little-endian format to file
/usr/bin/echo -en "\x01\x00\x00\x10" > file

# Over-write the fragments count in the superblock
echo Over-write the fragments count in the superblock

dd bs=1 seek=16 if=file of=img.sqsh count=4 conv=notrunc status=none

# Mount the filesystem to /mnt
echo Mount the filesystem to /mnt

if ! mount -t squashfs img.sqsh /mnt; then
	echo Mount of Squashfs filesystem failed
	finish
fi

# Stat file 999
echo Stat file 999

stat /mnt/999

popd 2>&1 > /dev/null

rm -rf $DIR
=================================================================

Fixes: ffae2cd73a9e8 ("Squashfs: header files")
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/squashfs_helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/squashfs_helpers.h b/fs/squashfs/squashfs_helpers.h
index 4088e598400f..524d4a77686d 100644
--- a/fs/squashfs/squashfs_helpers.h
+++ b/fs/squashfs/squashfs_helpers.h
@@ -55,7 +55,7 @@ static inline s64 squashfs_mkinode(u32 start, u16 offset)
 /* fragment and fragment table defines */
 static inline s64 squashfs_fragment_bytes(u32 fragments)
 {
-	return fragments * sizeof(struct squashfs_fragment_entry);
+	return (s64) fragments * sizeof(struct squashfs_fragment_entry);
 }
 
 static inline s32 squashfs_fragment_index(u32 fragments)
-- 
2.47.3

