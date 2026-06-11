Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6404F15E5DC;
	Thu, 11 Jun 2026 01:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781140358; cv=none; b=n42c+/BvqfK3BBiAisN6oh2sf6e5YrHzW3lG7Eqp0npCROBvEyKiuTx5DiR58U0jhDAI+mGhDJu3Vo3D0dUlzZVzrfQRL/XiM2DGazqJ7gadEY0sYFNmmctB2+VZIAEWQ8xDJrjFuBUseIl8jp0fDPE9jfy7ACm/9yaGOdKNl2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781140358; c=relaxed/simple;
	bh=4YcyQTVg1LXpPzvRDjYX7SQfokdlQiTPmiIU+2EPQKs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDTlRkfWVnUdke3NK9jR8hGejGzwewwvlvukmUxmt1lugbcr8TdOXONhq3azFDa/phwHBJwiaYzXw/AJCUZuJaloSxvUzxwdb732oPVJ5wYYgcyG+dEhaSuNyFMKXERXUBPZke1ShwH0QtX6d+VtleIfviBQZGGY0Mk2V0nO3xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdfWnKpQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdfWnKpQ"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 12BC61F00893;
	Thu, 11 Jun 2026 01:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781140357;
	bh=C3zz/+xVlomvqar3sllzZV4iWTbRq4WXC6OcDBDRvZs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=IdfWnKpQnjH7iOYhbsP6K0FpnUOp+/PRiPW1igzvvjKKhfxqk8WfmMOdo+wltggN1
	 oQBYidOw1sF9By1CsnJB1ZtvXC2Nr2Un6/HTWCXvxRZN9Y/J3yFem/yCWIQGB0rUrG
	 ChC2vjkaJYFJTxObzqNIKGxaEuLzLsjreHhwKOJ5MXLFU0XbJkEnrmtlPOd+qL0gBi
	 tWJyeDMorXX/iUkb54WZntKgG9gauHDXRWWI7oMyyzKyFcJBFmEFvZ/sXWeZToIHF2
	 TrlHBGzdSY3me4GSv0Uc4agnSXllwMgft2DsKcX+wMiqB2BXlCCw2heXyUpXdHpYbF
	 mvF6pXNT4fUGA==
Date: Wed, 10 Jun 2026 18:12:36 -0700
Subject: [PATCH 1/7] fsmount: don't truncate ms_flags in set_fsconfig_ms_flags
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <178114032590.139936.17432927514397915823.stgit@frogsfrogsfrogs>
In-Reply-To: <178114032546.139936.4052263259025005657.stgit@frogsfrogsfrogs>
References: <178114032546.139936.4052263259025005657.stgit@frogsfrogsfrogs>
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

