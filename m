Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB1E3043C9;
	Tue,  2 Jun 2026 01:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365175; cv=none; b=rQy0cV6Y5piQf76uEwQ1ZTsjXSkONO2i4zi09Q4SPh7lBv8OI7SN7MQxErkpsVST8prUNuIOA0J+DwWn14d8UW6DxQa7L2sQbAU/G+Vaol7NXyeRxnwb6eRGPcab29z3gEvh0L1lkgCoQi0lEpACKX296mIZKH81gX85EJPW/io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365175; c=relaxed/simple;
	bh=4YcyQTVg1LXpPzvRDjYX7SQfokdlQiTPmiIU+2EPQKs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ij0POxwsLGkAyDpXEWuOjZu96auR/jYGGRlQ95sDmrWWGYa+HEYSa0A/+PN5CpTcBnfjVmBNXrHAZmPRXwPpVA8C20aegRkIRWqhcrbUYWm3u5Ih0L5H+Fn0Jpdb9IGo7IzHyXKnUorzHX71QHbDsHJr9YNpk6RjtXK5c52y064=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NawyHHHz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NawyHHHz"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 422591F00893;
	Tue,  2 Jun 2026 01:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780365174;
	bh=C3zz/+xVlomvqar3sllzZV4iWTbRq4WXC6OcDBDRvZs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=NawyHHHzdoCb7rAwYAXM4N4aB1KVRay/LH5H6en5HTljkPhYAQKRe1jPPM/Jz/6se
	 +wVlrNiI6rbyL0gEMe/3jZrc/izGp+4AVL5sQueSz32eNvm8MPB3JLcw6gNXf/+WRX
	 ON7yHnUa1lDqJAhFWTShReb5U137VjNpyOJBLFR1ZobzRQviSmTSZLI+4SfKoBBT5U
	 hMUkI8yu7BJEp+6okGvFmh37JdvyC0NfmCe7j9IhUJ8yLbD3/0XNSmTreyvSme0T11
	 7vq3/UiJVETKEbCux/LotVvBfVPpnZDkbWDZpoJdNeTtKMDPx29sTNolLgZrKJaoMw
	 qp4JsWIjivhew==
Date: Mon, 01 Jun 2026 18:52:53 -0700
Subject: [PATCH 1/3] fsmount: don't truncate ms_flags in set_fsconfig_ms_flags
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <178036512159.432362.4314375052645032534.stgit@frogsfrogsfrogs>
In-Reply-To: <178036512130.432362.7597373245082703669.stgit@frogsfrogsfrogs>
References: <178036512130.432362.7597373245082703669.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The mount(2) flags (i.e. MS_*) are unsigned long.  Don't truncate them
in this function by assigning to int.

Fixes: 14cb7b93bb9688 ("Add support for the new linux mount API")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/mount_fsmount.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


diff --git a/lib/mount_fsmount.c b/lib/mount_fsmount.c
index 0f64880e045ba0..83768f0b8d193b 100644
--- a/lib/mount_fsmount.c
+++ b/lib/mount_fsmount.c
@@ -95,7 +95,8 @@ void log_fsconfig_kmsg(int fd)
 
 int set_fsconfig_ms_flags(int fsfd, unsigned long *ms_flags)
 {
-	int ret, flags = *ms_flags;
+	unsigned long flags = *ms_flags;
+	int ret;
 	int i;
 
 	for (i = 0; mount_flags[i].opt != NULL && flags != 0; i++) {

