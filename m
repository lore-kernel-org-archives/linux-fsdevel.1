Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A8A4252B7
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130127; cv=pass; b=kQFwmgXUsK9G5HuGkKx70msLlxAvYixK8F17ZaVMiOTx+WBo/XPs6slKedErHDTQJ/UOTQCxvFxeIgCLtXryfeXNcK2O5dFic/wcKk88ooyrHZqrxHfHVlqGr6tGc7OYOgrlJca284SBrolteXDMF7kqjXDX3lN9UNrmk0gI2TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130127; c=relaxed/simple;
	bh=D0GwEBPZwDSpF3t7PXggJDLj9yEZl1vW2yUqVJoxFWo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=K4npsKWu6jIS1rsO5snAoveQLK8v0TcaRfPxyTxOgKeNt0eB1WrUMeLz1tfU1mYVWEqEl8DXeuXPxxeW27BTTazFWfQh4P9QVRUUAq33VOif9Bu7smWJDqHhMlhUIByqhfGJk3JykdS1t3SszESuyLBxW1b4NWIPmYFLhixSAh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dz8rrP2t; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dz8rrP2t"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-90a80860d35so10083616d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 02:02:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787130121; cv=none;
        d=google.com; s=arc-20260327;
        b=RjVEKW1r+UVAELWxalXbCA6OdUI9lZJkKNi8Q7NEvvlE4Pg7Sf0gk+U1anMkf9W3KV
         9tViDQXGWORbFcrQC9hZn/BAu6g6wfCJJFMxApCsYR39qFIShq1iKpA0xMBa1AmBs6Rs
         UQtBgSiYk//MSRRMi+7Lpim65C3iFWsekSd2nScXVqYqn2wq1jETjNHEvpo588RAvG0I
         UdJV07QuPT15yUFMZS6NkynpVa/qu2QnOCWqDPDcaGM4lubqlskD7vC1e5V6YnttWo2u
         DxR21G4PnWORQmVR9Keze9BcUNwfmLmuqP1IK1FKf8ivDEaI7BrKUpbRcTWSBufX09PJ
         Yq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=lh94NleeH3lqZAsalMlCWnYENzl0FPI/Q7IkjuuaW10=;
        fh=kfky24mkMxZPecXjBCfrYDPy0pHUsXi5NLwa/xuk3YY=;
        b=phbfePdBt4E/Q17ZUr2+sNmZfXZQdMWoxqg+hZBv+pM02/FrG+mns0xbqcGlDmPZtf
         WlNV2xsnu3KHqIV7y5cA5jCgX+hcRJeuwZMCcq9uE5/0wzY1LlDeSrDpIYkf1xBoBPgG
         9nw1k75pBWdkUbzUdknO2xSF0FYeoxhyhLqg9TUs1Q6IfEDXdL4kJyG60UXaGWStSbRf
         KdIb82oL21+WP1BtIMXPMqDPJ0UYVHgx0ufIcXN/Fw/DlrI2glo/tYcaJmkyxYxNbOXN
         e/LtI+p7212xzT8KyjVLPNpPMXcXzbuRNnh3Xp77Xl/cZF53ImNQv+CrVifgVH9NdNDx
         XxRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787130121; x=1787734921; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lh94NleeH3lqZAsalMlCWnYENzl0FPI/Q7IkjuuaW10=;
        b=dz8rrP2t8qYmJxroxO4MwjCEU01TW9LbhATH/V4VRIKYzNhUP1KW9OeeDCCPuiXZVw
         vhhvcNTyWBHkUqxWyLQNEnoXTYdid2FseKAS7tVSdxDX4pFLJ7bg7HfjC3DDB7Q8I6lg
         3/g3QWjbZhqT2Wy3SdaP6RseR026Eby68RMwV5n7a7qpy+4DfsxvLsNfZhfnqyOwP6yi
         W4jyNMFmiQBPyJj7aPTneGbOzzoTqb4NJyG+/TT5LGZc1UMF2EPKPmj/A2VrPLdrhRDf
         5igmiFifdn4REO+GyJa0mrZz2Q80ERc5K0YM2DKIrA1iCFVjEatWmuv/4MPHSlGWIE+O
         CRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787130121; x=1787734921;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lh94NleeH3lqZAsalMlCWnYENzl0FPI/Q7IkjuuaW10=;
        b=cAQw+zj81q7UYQcrQRKe2LJvEF25r0mN/Xr9TuZSOGTwvSt/uABhMNU0YJ5cqMVY7y
         k47zJPSv9yfg9vcFXNkB2auxWzaXg8Vr9xrn8/NXlcMRWgIxIjmneylFi9MUSBYe/lqL
         nBIDBoucmypPtKiWqQoNJL+s7o8uEUZfGRX+jd+HJ/a3CGBCZN4/gZB/QAMMTl52W6qM
         sIGAm7mnFR+GL3je95RMwjLsOrOq+AWfpZvYJGSLbHIThTDjVoU5Fi9z+keqKWidij14
         lILpIxbp+oDVJJL0dWOKDNEkm1aFhgNPliTG4R2Kfh8Hm2DZ2EqVu8NV1IKcmIeWmE8n
         t+1w==
X-Forwarded-Encrypted: i=1; AHgh+RoYm6qylc/YNkTEXEZ1/nqpxNl5P+Mt00QPhDCKLejjtL+JBIYVLU3WUJfSFB+hKn9ewgyNJdLlkcUUvJMg@vger.kernel.org
X-Gm-Message-State: AOJu0Yxij2IAE3DMAg0UqbBH+q5zZ8kjcrLD6wcuNgRBa0bdvA8j5Q3w
	T0evAVupbgvrwjT2f0eI3sQhEgHPXeevGZ+XKC2njFbS6BaIRsuYeePG6sIm0tF+aTq79x2i8dP
	j0kf40DLE0qCKLAurWt7ja6HYVh1EOmM=
X-Gm-Gg: AR+sD13SNre9qLPoWz60Q+cIm6QGdXmkRCnSw9pYXnYIuUqZMSvjWLkaS/dYoy872fl
	iXnKrnMi5PuGDCm88qlxvjw1LHvquxtG1mhO0bh7tLKxOxJey/zvjAfEOovUmlHR7kEsGfWvja2
	TlIoGcexPofuyEH8003YcYYtgjP3kUg26mZWmDlocegWK99a84B2UuJLzhJ+vPHyYaWyug9DcKZ
	ZHNHLwXM+dM0mFFSm1SCwAQdYr+AdoAuqNijQq2Lz51H+Khn8ltGF/nhZdHYGA6Q6+OhkAeTwRy
	Y5+ffOSrG/Yaf3SFgwq5ce1DuzeA4/hI7Sqdc//9/uXwsKO5xMwtq7ixEaEi2m+4/pe8P6jSY1P
	ynQ==
X-Received: by 2002:a05:6214:29c8:b0:8f6:8d46:5f47 with SMTP id
 6a1803df08f44-90c5e94b0bamr26750206d6.5.1787130121135; Wed, 19 Aug 2026
 02:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mihail Leoca <mycroftmih@gmail.com>
Date: Wed, 19 Aug 2026 12:01:49 +0300
X-Gm-Features: AcwNN1UZEt3ggu3Yr8zbH8iDaQVSJ6zFJMtNLV1WT8KYPzFredJLl_Hiy6zE3-I
Message-ID: <CAN4jxfXBFy9YQARm8O5SgKEg4ME1=jXShZ-AQ5MXXscQqDtzWw@mail.gmail.com>
Subject: [BUG] smb: client: data loss - writeback subrequest is dropped, not
 retried, when the AEAD allocation fails
To: linux-cifs@vger.kernel.org
Cc: sfrench@samba.org, smfrench@gmail.com, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, dhowells@redhat.com, ematsumiya@suse.de, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

A large buffered write to an encrypted SMB3 mount can lose data. Every
write() returns success but one or more wsize-sized ranges never reach
the server. ENOMEM is reported once by whichever of fsync() or close()
comes first. On the server a lost range inside the file reads back as
zeroes; a lost range at the end leaves the file short.

We noticed the corruption in June, after upgrading from 6.1 to 6.12.53.
Everything measured below is from a reproducer.


The bug
=======

1. Every encrypted write makes one contiguous allocation for the crypto
   request, in smb2_aead_req_alloc() (fs/smb/client/smb2ops.c):

p = kzalloc(len, GFP_NOFS);
if (!p)
return ERR_PTR(-ENOMEM);

   At wsize=4 MiB with 4 KiB pages num_sgs is 1027. The scatterlist
   array dominates len, so the request is order-4.

2. On failure -ENOMEM reaches smb2_async_writev()
   (fs/smb/client/smb2pdu.c).

3. -ENOMEM is not classified as retryable. On 7.x smb2_async_writev()
   sets NETFS_SREQ_NEED_RETRY only for is_replayable_error()
   (fs/smb/client/cifsglob.h), which is -EAGAIN and -ECONNABORTED. On
   6.12.y netfs makes the same test in
   netfs_write_subrequest_terminated() and retries only -EAGAIN.

4. fs/netfs/write_collect.c marks the subrequest NETFS_SREQ_FAILED,
   records the error on the mapping and does not resend the range.


Affected
========

Reproduced on kernel version:
- v6.12.53
- v7.1.5
- mainline bd5f485f3f02

It needs:
- 4 KiB pages
- an encrypted mount
- buffered I/O (cache=strict or cache=loose)
- and the default wsize=4 MiB.

The classification is old and has never covered -ENOMEM. What changed is
how reachable the allocation failure is:

- before v6.3 kmalloc(len, GFP_ATOMIC) no fallback
- v6.3 onward kvzalloc() vmalloc fallback
- 998a67b95468 kzalloc(len, GFP_NOFS) no fallback

998a67b95468 ("smb: client: fix crypto buffers in non-linear memory")
shipped in 6.6.112+, 6.12.53+, 6.17.3+ and 6.18+. These stable upgrades
took the fallback away:
- 6.6.111  -> 6.6.112
- 6.12.52  -> 6.12.53


Reproducer
==========

1) Samba share on /srv/share, exported with

smb encrypt = required
smb2 max write = 4194304
strict allocate = yes

   mounted on /mnt/cifs with

-o vers=3.1.1,seal,cache=strict,wsize=4194304

2) The writer, cc -O2 -o writer writer.c:

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

int main(void)
{
static unsigned char buf[1 << 20];
size_t n = 0, total = 192u << 20;
ssize_t rc;
int fd, r;

memset(buf, 0xa5, sizeof buf);
fd = open("/mnt/cifs/data.bin",
 O_WRONLY | O_CREAT | O_TRUNC, 0600);
if (fd < 0) {
perror("open");
return 1;
}
while (n < total) {
rc = write(fd, buf, sizeof buf);
if (rc <= 0) {
printf("write=%zd errno=%d\n", rc, errno);
break;
}
n += (size_t)rc;
}
printf("wrote=%zu\n", n);
r = fsync(fd);
printf("fsync=%d errno=%d\n", r, r ? errno : 0);
r = close(fd);
printf("close=%d errno=%d\n", r, r ? errno : 0);
return 0;
}

3) Inject during the write:

F=/sys/kernel/debug/fail_page_alloc
echo 4  > $F/min-order
echo N  > $F/ignore-gfp-wait
echo -1 > $F/times
trap 'echo 0 > $F/probability' EXIT INT TERM
echo 50 > $F/probability
./writer
echo 0  > $F/probability

4) Check the file on the server, not through the mount, which still
   serves the original pages from cache. The file is 0xa5, so every
   zero byte is lost data:

cd /srv/share
ls -l data.bin # short if the tail was dropped
tr -dc '\0' <data.bin | wc -c # bytes lost as zeroes
od -A d -t x1 data.bin | grep -B1 '00 00 00 00'


Result
======

Three runs on mainline bd5f485f3f02. Every write() returned success
and fsync() returned -1 ENOMEM:

run 1 full length 80 MiB lost 20 chunks
run 2 8 MiB short 92 MiB lost 23 chunks
run 3 full length 96 MiB lost 24 chunks

Every zero run starts and ends on a wsize boundary and the chunk count
matches the injected failures in crypt_message exactly. Raising min-order
to 5 misses this allocation entirely: 206 injections land in
netfs_alloc_folioq_buffer instead and nothing is lost.

Dropping the fsync() from the writer moves the ENOMEM to close(). v7.1.5
behaved the same, losing 104, 88 and 92 MiB.

The error is reported but the data is already gone. With the stream
failed netfs_collect_write_results() advances collected_to over the
untransferred range and ends the folios without redirtying them;
fs/netfs/write_collect.c has no redirty call at all. An application that
checks every return code still cannot rewrite the lost range. On the
issue side the same -ENOMEM is treated as transient and redirtied
(fs/netfs/write_issue.c).

I would expect a transient -ENOMEM to be retried rather than treated as a
permanent failure of the range, or failing that for folios not to be
cleaned when nothing was transferred.

Happy to test patches or add trace detail.

Thanks,
Mihail Leoca
