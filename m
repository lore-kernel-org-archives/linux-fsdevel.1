Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32013D411A
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792187756; cv=none; b=iiy1j1/HrWLq3rUghgnSqaDDMtabhEuhVvczg7U98p4Mk06YOYtcu6rcVyYO3n9whOZBXVkuZoZzuDPJ1huAbmmEEpKPWfjdNJexC+xULtlNN+48vXrlkp6YaGsJgjwupBBmEmBTcK5En0BgKf6qd1m9/qxgMulyhHqFiOIFQdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792187756; c=relaxed/simple;
	bh=6PlFPl5yyg+7VyuqK7O9sVNkpaIz69EVRd4L3Av4NYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tcrxa8l7Z+iwoqFtqfMN3ImpxI1nE9WlXN6yYwGdOwns2nDZr6d7bS9QiNcTxVQIX2TYl4wnhfehLmXEAC3lExrJAuwZ9WtpfMDV7vOFuZDThkk54NRKA11AN/Bh5N0sRrIAp53fa/dE+ImHTZu1XVBiFJuWRX+kF6vllRwOlPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoRCLT1C; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoRCLT1C"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35a31bb9fb6so682507eec.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 14:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792187753; x=1792792553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LEYeqJ4N4i7YjnqQCG2LK1nS6owgSqR6t1k2WUrMsnw=;
        b=SoRCLT1CKgL3vDityzJ3U6ecYc16qj0hQ2nhepLOMNuXtnLZ+mqEYX5w5G97VYFrr9
         BOmYKmV5EDsmBsKxii4OtcUG7HAoDDEPn7cX1r80sPHfKRkCVe+W6I6K1exlkAc0e2kS
         LkNiOtY2AafxWGGwxzlhAcX9Vi8K1xNzQBjsGYHqoHxTK7eWhyhAV6/p7VCK/n/UIfn7
         +rY6z5XPFSKtJZbPJf9xkuDrELD0sEOL7tEB8oieWtGRevS6L5gAqmR3zHQBZQ6SW7pf
         +PTnsYwIesisTyOZgzVhLpNUF/CcUDWhFtOccjnNJjVDoRODUy5s5GGJDeMNRWyGyur6
         0TJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792187753; x=1792792553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LEYeqJ4N4i7YjnqQCG2LK1nS6owgSqR6t1k2WUrMsnw=;
        b=Uk4OTyCXYoaSAbxTz3MEjrNXr+Tu6r8BC+PqNnXmhawCOisxA+Z4zwoc0DZYR/6xcI
         55FYFKBeuOSML59lpx9nIYorE9z78R+Cf5dNSj2S8gGBi2xkybOGeTJJP+7VN6+bIkYs
         GuGFA+VjMhizvF10/bpxuUegdfnDeIz9Jcdnw4IsWgio/omaYSKPvchnizqc8+9gf+w+
         pRWqAsLvmobtFJqbIxh0ipiVuUMSTA3jQBNjfnvUOS8yGiC5q6ncTU+ihy1oJb4W1bN0
         +oUxfoFvInyO2BUeM4ZEpGssnBxyEaDbh456jQuprpJV8pvS9RLYVVBI3YT6GyPnQF7N
         DBwg==
X-Forwarded-Encrypted: i=1; AKwUvBx4gmd+JXl1wlrRoKrzbyhYI1zkgPRkJ5AxTYhLcewWQldcLkqLZ8/tsS0aoxv6GUCQmGhQeYhtG7xLquE4@vger.kernel.org
X-Gm-Message-State: AFq9FYIN62511JWVGllj1AimQFYO6GvnXBf0Y0Dw1kixrKvSh+MaxUT+
	X8Q4mJox4e4KmdGxQAHGGmgBnQlW4oMjW6vo+Towbp1Kv/1aCU+RtkLK
X-Gm-Gg: AYBFou21THMMoK0urGqT2jijbLABcQT6xtE4ih6HL7TYlQU3cNtfagBBKk4lfyeeFtB
	Zm3ngq+AL37ZUmmWVrOeY8oFSNN+DDR+CwOWh9BYZCS9gTAwpgZOTNFarP6qjIjIty8LrskaoYc
	6FP38r4cR9N422/SWpaaGvxJfrvXwk8KxRDBgqNdv5o5Zi3eo1Fur4Jjmb6JQSIZpGuaxDTAxEy
	Mk9uHZTWByVSILG/dy8j9sIJ3WntYN1+oqIQ5TgHQ8ijJTT2YdqyS3FRAp9Y3jHTLz7pE7fzhB+
	P1iI4xvnBVVJlt0KAl/crmiiBbuxvXrdNUS6K69wMHPDFUWxocX9dXJjp64NSTYZDO8wWB1w5Y1
	ukC5+ItrQ6ipnh2q/nra5CgMcNkhwixXgWYxnTLN7Rmw1YjygCujr2XEnS25dDeCC30haqBkeMD
	CtfDaOzbZw3mVEQ+qBWleuG0Fa9r7xwZWM8MX2W0M3iyBEEYdH7Vq85aOHGxQYCuxS4opVyOggc
	WQSNWwscA==
X-Received: by 2002:a05:7301:52c7:b0:35d:d671:933a with SMTP id 5a478bee46e88-361a185eff6mr1110380eec.15.1792187752437;
        Fri, 16 Oct 2026 14:55:52 -0700 (PDT)
Received: from FredPC ([2600:381:b915:8f8d:c200:c442:48e:8bde])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6791sm10537981eec.6.2026.10.16.14.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 14:55:52 -0700 (PDT)
From: Fredric Cover <fredric.cover.lkernel@gmail.com>
To: Paulo Alcantara <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fredric Cover <fredric.cover.lkernel@gmail.com>
Subject: [PATCH v2] netfs: Fix off-by-one in the flush range in netfs_page_mkwrite()
Date: Fri, 16 Oct 2026 14:55:17 -0700
Message-ID: <20261016215517.33292-1-fredric.cover.lkernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a page fault wants to make a folio writable but the folio belongs
to a different netfs group (e.g. a ceph snap context) than the one the
write is being made under, netfs_page_mkwrite() flushes the folio and
retries the fault.  It does so with:

	filemap_fdatawrite_range(mapping,
				 folio_pos(folio),
				 folio_next_pos(folio));

filemap_fdatawrite_range() takes an inclusive end offset, but
folio_next_pos() is the position of the first byte of the following
folio.  The range therefore covers one byte too many, and writeback is
also run on whichever folio contains that byte.

filemap_fdatawrite_range() is a WB_SYNC_ALL operation documented as
waiting upon dirty or in-writeback pages in the range, so the faulting
task can stall behind I/O on a neighbouring folio that has nothing to
do with the fault, and a neighbouring dirty folio is written out early.

The off-by-one dates from the original implementation, which passed
folio_pos(folio) + folio_size(folio) as the end of a
filemap_fdatawait_range() call, which also takes an inclusive end.  It
was carried over when the call was changed to
filemap_fdatawrite_range().

The flush of the faulting folio itself is unaffected, so this does not
cause data loss or incorrect results, only unneeded writeback and
latency.

Fix it by passing folio_next_pos(folio) - 1, as the flush_content path
in netfs_perform_write() already does with fpos + flen - 1.

Assisted-by: LLM
Fixes: 102a7e2c598c ("netfs: Allow buffered shared-writeable mmap through netfs_page_mkwrite()")
Signed-off-by: Fredric Cover <fredric.cover.lkernel@gmail.com>

---
Changes since v1:
 - Correctly CC netfs@lists.linux.dev
---
 fs/netfs/buffered_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index ecf119b4f9166..b398c3bef6f3c 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -579,7 +579,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 		folio_unlock(folio);
 		err = filemap_fdatawrite_range(mapping,
 					       folio_pos(folio),
-					       folio_next_pos(folio));
+					       folio_next_pos(folio) - 1);
 		switch (err) {
 		case 0:
 			ret = VM_FAULT_RETRY;
-- 
2.53.0

