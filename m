Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794872146;
	b=MgBY/AIoLo2BO8NymjcK2RWNZOtVz9OUD1WnYd6Y5ZhmVXSkvj+sQuWuCQgPgsmH+Aav
	 QyrV2Kf4/cyUNx05cTiQuHWiqh/r8UcV0AN4yLYlD5x2lMdUyOFFwK++2qQSO92j4hdwR
	 Y1kEuQKmDiA6aJFSW1to7L253FKVwoocbNUB2gWlky82gJQEUi4bIxh5KVZxecpBF1Ssm
	 3eKMfJfPQpNKY68nLYc6s+4MhJKxhm38ggSB4dhdU5wQvC0kq7xB/Md1bX8QYneNO/ZCY
	 aJSNDymnDqvaOZDpQngtKEW5/wDLzx2Xs0c2uoPKgzUYmQQ90A/XrHrEGxE0R9hAthA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794872146;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=v+LAa0aQ36GsHbhQ3RC8UkigsNbW96LolIZXuEySS+o=;
	b=YY2fO0zBFy7Wtg5Y9I0Ic71WSq+KXyWdBMgA45TUkhHCitajSuPqgrAvtR51WcnIEGpU
	 B401q4N7b9PFAz0nMjEDt8VfA4Dcxax2mXFNCOGMb6bge0SM83OSyxNC5+EZoVHRrYJjG
	 8UBLMudAF40023/N7WZhUpnGH2uWCVqs2iQPFJuIiJ5ihi93p9UASBHrCu6FIoqbSsSd/
	 SJXlb5TQYOORa90sjx3z7I9S5yhXXgYLApFua9dL93NWgg3dmFJdtMX38jdn2oygE2YTC
	 w/U4dupfpsOjlnCDkSm+qHsc1mC3L9A7hrAtMN2TI16LlnuQJoVrJCcMltJhIyMKAiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=logarcheon.com;
	spf=pass smtp.mailfrom=logarcheon.com;
	dkim=pass header.d=logarcheon.com header.i=@logarcheon.com header.a=rsa-sha256 header.s=protonmail3 header.b=jP6grMXR;
	arc=none smtp.remote-ip=185.70.43.20
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D41C606A31C;
	Mon, 16 Nov 2026 23:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D41C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=logarcheon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=logarcheon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=logarcheon.com header.i=@logarcheon.com header.a=rsa-sha256 header.s=protonmail3 header.b=jP6grMXR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=logarcheon.com;
	s=protonmail3; t=1794872140; x=1795131340;
	bh=v+LAa0aQ36GsHbhQ3RC8UkigsNbW96LolIZXuEySS+o=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jP6grMXRLcxGF5ib9XLyX8GPcWsfJmcu9M2sM+sGS+rkhpU0jJZI+VtVcCAlNO9WT
	 3M8uxi1hGXUzNSsNEFIpGz0mZ7ABpfmR4hjiEOHTLpiII5rt70mvbAvKzz9zvvSfQV
	 Z942RZ7eNExd8PleIg8jKSkG4f+gZakMq78rmc3WQZVhQF2SR+e6Jn59FI3Rus9jK+
	 /y3tvANCOMAOJkvVLjoP1zIcz2YYxTXTmpRUgYohzq6MiK+Go8NYOEjkYcRyhuQNj3
	 0mqTq5eZc76NmVBSS/TAHRydBDz6N/LEUSjNtIvPgcgupszrR+SSYlwhzvhEsU3Dpb
	 L+UpoXaa1+pNg==
Date: Mon, 16 Nov 2026 23:35:35 +0000
To: Andrew Morton <akpm@linux-foundation.org>, Phillip Lougher <phillip@squashfs.org.uk>
From: William Chuang <founder@logarcheon.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Aibing Chen <chenaibing@cmss.chinamobile.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, William Chuang <founder@logarcheon.com>
Subject: [PATCH] squashfs: set an error code on the directory header bounds check in lookup
Message-ID: <20261116233530.47177-1-founder@logarcheon.com>
Feedback-ID: 145408520:user:proton
X-Pm-Message-ID: eb9ee0fa798e74923e88ed9d33a3351e5b6aef6e
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The squashfs_dir_space() check before the directory header read in
squashfs_lookup() jumps to read_failure without setting err.  The two
checks before the entry and name reads were given an error code by
squashfs-fix-variables-in-directory-code-and-add-more-sanity-checks-fix,
but this one was missed.

On this path err is either the positive byte count of an earlier
successful squashfs_read_metadata() call (12 after a directory header),
or uninitialised when the check fails on the first iteration (for a
directory whose size is too small to hold a header).  squashfs_lookup()
then returns ERR_PTR(err) with a value that IS_ERR() does not catch, and
the VFS dereferences it.

A model check (CBMC) of squashfs_lookup() as it stands in
mm-nonmm-unstable produces both cases: a 15-byte directory gives
ERR_PTR(12), and a 9-byte directory gives ERR_PTR(<uninitialised>).
With this change, the same check proves that every return value is NULL,
a dentry, or ERR_PTR(-errno), for every directory size.

The header check validates on-disk directory content, so jump to
data_error (-EIO) like the neighbouring dir_count check.  Aibing Chen
posted the same hunk as part of "[PATCH 2/2] squashfs: return -EIO on
out-of-bounds directory entry in lookup" on 2026-11-14.

Fixes: 5213b0a08263 ("Squashfs: fix variables in directory code and add mor=
e sanity checks")
Signed-off-by: William Chuang <founder@logarcheon.com>
---
Notes for reviewers (not part of the commit):

- This is the third squashfs_dir_space() path; Dan noted two.  The fix
  goes on top of squashfs-fix-variables-in-directory-code-and-add-more-
  sanity-checks-fix and can simply be folded into it.  If -ENOSPC is
  preferred for consistency with that fix, I'm happy to respin.
- squashfs_read_inode() has the same problem: the two new
  "i_size < 3" checks reach failed_read with err =3D 32 or 40.  That is
  fixed by Aibing Chen's "[PATCH 1/2] squashfs: return -EINVAL on
  invalid directory inode size" (2026-11-14), which is still needed.
- The model-checking harnesses and outputs are available on request.

 fs/squashfs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/namei.c b/fs/squashfs/namei.c
index dc63920..1945e5d 100644
--- a/fs/squashfs/namei.c
+++ b/fs/squashfs/namei.c
@@ -203,7 +203,7 @@ static struct dentry *squashfs_lookup(struct inode *dir=
, struct dentry *dentry,
 =09=09 * Read directory header.
 =09=09 */
 =09=09if (!squashfs_dir_space(dir, length, sizeof(dirh)))
-=09=09=09goto read_failure;
+=09=09=09goto data_error;
=20
 =09=09err =3D squashfs_read_metadata(dir->i_sb, &dirh, &block,
 =09=09=09=09&offset, sizeof(dirh));
--=20
2.43.0


