Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4B91643B;
	Wed,  3 Jun 2026 00:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445697; cv=none; b=ifGVt4OYH7WHOtLHV9hPcZWhjVlVqkRf1dZDw3fq9C6uzezOCwouuEfIKP6dLKD78id8z5lUkhxB5aEl+gmzUv/IwehSeyAl3gfX8e8IcUk2xirI9WjdD94OWPwWOSnOYcrFsICd33XHrn4BlySJEDLfzj8+/2fX/VVzocOPTO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445697; c=relaxed/simple;
	bh=4YcyQTVg1LXpPzvRDjYX7SQfokdlQiTPmiIU+2EPQKs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bj+9eAGfAvjLqTTT05oK4WAPB/PaSZGTqP+pfVKpM9s5mEGO4WRGgCLggCfjyzapG0/hyJMA9Sbt3K+8mEmOnBAEZeuDTX/wTM6OKXxlBFTj0yjTBK9YEzDs/poMkwkwHw2zwQvhFrWVqSxS72M3Azu+Pfl06QLV1juYwqJjTcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GD0scI2T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD0scI2T"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4BD1E1F00893;
	Wed,  3 Jun 2026 00:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780445696;
	bh=C3zz/+xVlomvqar3sllzZV4iWTbRq4WXC6OcDBDRvZs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=GD0scI2T3fLZYXLcGfVLeWdwspDIwAgwSfxWzlTuw5szwLG8hKLsL+FshlY9sdn7C
	 Wx3yxNFibSiIegclgw2EtDKaJ9joVuGKzs2ohxhLl1aMxGH3l5iDx6eWpGzJ5MufeO
	 e4OPKxmiNvKr4thqDic2hc6yE7pGoDxbtCRDwLvpjseS4ZT9g/mymEp5sBJoD5NkNb
	 k/asBDgsvbmRKpQlF95JoK7iOY3ALDTaG//WJVVYQjPpdiYL8H1zBOd+fWdjpIzGhr
	 MtJaLM45tK4ofg0cprpZoKWQnMpWiqvVynsnEn1PdFgLT4heAOB6AjkHcN0VjAlHs5
	 lfkVpeqMeqfyw==
Date: Tue, 02 Jun 2026 17:14:56 -0700
Subject: [PATCH 1/6] fsmount: don't truncate ms_flags in set_fsconfig_ms_flags
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Message-ID: <178044567844.1435997.7649583407724131504.stgit@frogsfrogsfrogs>
In-Reply-To: <178044567804.1435997.11438899616254127750.stgit@frogsfrogsfrogs>
References: <178044567804.1435997.11438899616254127750.stgit@frogsfrogsfrogs>
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

