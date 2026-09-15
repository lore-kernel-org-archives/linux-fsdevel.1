Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3F5471CFC;
	Tue, 15 Sep 2026 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467761; cv=none; b=coasbu8ShpyChBUoISS0eyVmC4mSQ9UkM3GM09NRPVYfvFo0Rbp6Ss3zMoHvzY/vIJZMGkh8oOe+HFKk893fy85aUux83z90ZbYCigRnkqpEvQ4Yc6epTtKpoqAKDjSoeNdaa9XDgEZVRovAuwmDJh1SOYGDDMhGdEGP8cR8mh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467761; c=relaxed/simple;
	bh=wifUit0zCXT+xmFYL1pQ/rbqJKzU2mv5TqNUZ8hoflY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dVG/SB0WeSfugOQo7eWYk5USnmLxv4OtbgBkpkqVV0SeuDHb5HWXB6Hx+M4lVV06MkAMSr384aqD8wQoAH2DR8qlfKVIMdWlp0aLAbxP+aQnW+4qHQNFI80aF7CQZWGblbtSLzx0TICJZlHOHukYcMS6pgcfq110s8PPuy28Z8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EODRVZ78; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EODRVZ78"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26131F00893;
	Tue, 15 Sep 2026 10:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789467760;
	bh=izsLFS0tkOxNtjh+qEH/VSp+IfMxwnWHO6ubkr1wAqg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EODRVZ78i64iioiiJvZn0gwShjD168VDnpcnxJuxCRm4yrd3zyqZoh5bOljoZiwfe
	 +8zd8Q9os+vLh3jCvABHT2sBtW5p8CFSGyuYO1jtt0rejHv95+7wFzRkbqahwfHilN
	 ZZ04SPifZfBlB28YP6Uv9qzNGZ22HGkkNm8Q2sO0Jn7enprwmJCnAeWCDzguxeEIuA
	 2d77aG9wT04OX9CE54PYplS27VGLo0FfZ+z4C3KksZsEgrGxw2YsifwwRHuc3oUi83
	 5Q7pTOpaEN//9knrINWz+Bx1fWSnicpbJvNp88tAK8RXFkTclMq50O5JJWXN7dQMLv
	 4kbA6gcy4Dbig==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 12:22:16 +0200
Subject: [PATCH 1/6] coredump: don't switch a dumper that has no files
 table
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-coredump-fixes-v1-1-f354ca41780c@kernel.org>
References: <20260915-work-coredump-fixes-v1-0-f354ca41780c@kernel.org>
In-Reply-To: <20260915-work-coredump-fixes-v1-0-f354ca41780c@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
 io-uring@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wifUit0zCXT+xmFYL1pQ/rbqJKzU2mv5TqNUZ8hoflY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWStlMmImc9rOo+RqeuSpEnJZ5WmPjunTsOA5JMMBeUe3
 xbdzDDpKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMjfZYwM5/eJvpWveKOeNl8w
 WXaXnm/jmuZnl6TehTm3Ma7X0PzbzsiwXXdnsMA/5dtLX2TtPJVtuDRaOsevkOFpjELZRM6SF15
 8AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Tasks without an fdtable are skipped in coredump_close_files(). The
coredump client itself doesn't use the same check. Since
put_files_struct() doesn't tolerate NULL it will oops for such tasks
without an fdtable. The prime suspect for this behavior are vhost
workers. Skip the switch for a coredump client without a table.

Fixes: b2b36bcb13ea ("coredump: add COREDUMP_CLOSE_FILES")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 1fba3fed1a07..791a9268ed96 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -579,7 +579,11 @@ static bool coredump_close_files(struct core_state *core_state)
 	/* Use the dumper's real creds not the overridden ones. */
 	scoped_with_creds(current_real_cred()) {
 		io_uring_task_cancel();
-		switch_files_struct(current, files);
+		/* The dumper itself may be a vhost worker without a table. */
+		if (current->files)
+			switch_files_struct(current, files);
+		else
+			put_files_struct(files);
 	}
 
 	coredump_wait_inactive(core_state);

-- 
2.53.0

