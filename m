Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1015823D7DC;
	Tue,  5 May 2026 23:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778022571; cv=none; b=hDLeLNneqwtWUY8C1OSbRKlWJEwwc3R6uheye1tCWp9ttJIgLa37UtlbIOP2mNoYukrt4/0ljDice0XLXxV/Bk3l1q1OxY3ztgyuVg6wsG4CU12wDpUUYcFkjqqHQ6Y3l9nSh0uGv4KGmRoDrdJ4CiSOGzqfgmLy8jeg4t1ja/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778022571; c=relaxed/simple;
	bh=W76Pw9a/gOd7OcEeYfxgBCZN/hYWM0psOfFpuw6XJEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sb2F3YmlLgWgzieVRQI+8XFSwo4FfSPtSWr/saBNdK0EmJidCnCBzbUG398u7rdwrkQXYScAvdZhJ32wHBuCQHMd0T25d8bxvt5Gmeo8uTz9cGlK02P5+EHlhDQAJEPFK5RqtvRvHPt0nLz+BJeaqzXyrc3zh6KT4Sw1r92Y2Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p937Y9m7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p937Y9m7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2B0C2BCB4;
	Tue,  5 May 2026 23:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778022570;
	bh=W76Pw9a/gOd7OcEeYfxgBCZN/hYWM0psOfFpuw6XJEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p937Y9m7IXmUCO3kNzKkDwvpTIFbKfA+u8U8uMJJUeNdy0pTz2XtjxEl7VJ3JOCck
	 Th0QjqCxjJftKe+DoPG/M4om3QgBaDeuWdXMfrLlPSxsKKXj81KO2BEf/dCyxCdner
	 BLwzo9Drp9X65lWnjs3szwOUb5iibf2CorE0pMv1Kc0deRA4aCNfhUJdRC8KzYOOMt
	 /XyOgR27Lg+YzSZhX2pCirhjnM2UAUBRv/3gY37ahhiEVhENKrzW4+pRi/B5UU7LQ+
	 S2zdnV5J7MCywXg5VolqLDfLv0LA1k9AFKgB5gfjaXSyWcRulK8knWai41YBWcx8a/
	 V+kv21bPpl1jQ==
Date: Tue, 5 May 2026 16:09:30 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Subject: [PATCH 3/2] mount_util: fix mount_flags entries for MS_RDONLY
Message-ID: <20260505230930.GD7739@frogsfrogsfrogs>
References: <20260505052133.GR7765@frogsfrogsfrogs>
 <177795853450.1133476.8692790530314969678.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177795853450.1133476.8692790530314969678.stgit@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

MS_RDONLY maps to MOUNT_ATTR_RDONLY in the new fsmount API, but the
table omitted that.  Fix that.

Fixes: 0d7e72541564a5 ("Unify mount flag structures and remove redundant is_mount_attr field")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 lib/mount_util.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/mount_util.c b/lib/mount_util.c
index 1a0aec9bfe1a70..7ab1dba91e28e3 100644
--- a/lib/mount_util.c
+++ b/lib/mount_util.c
@@ -110,8 +110,8 @@
 
 const struct mount_flags mount_flags[] = {
 /* opt            flag             on  safe  mount_attr */
-{"rw",           MS_RDONLY,        0,  1,    0},                      /* fsconfig */
-{"ro",           MS_RDONLY,        1,  1,    0},                      /* fsconfig */
+{"rw",           MS_RDONLY,        0,  1,    MOUNT_ATTR_RDONLY},     /* fsconfig */
+{"ro",           MS_RDONLY,        1,  1,    MOUNT_ATTR_RDONLY},     /* fsconfig */
 {"suid",         MS_NOSUID,        0,  0,    MOUNT_ATTR_NOSUID},     /* fsmount  */
 {"nosuid",       MS_NOSUID,        1,  1,    MOUNT_ATTR_NOSUID},     /* fsmount  */
 {"dev",          MS_NODEV,         0,  1,    MOUNT_ATTR_NODEV},      /* fsmount  */
