Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ECC3C455B;
	Mon, 13 Apr 2026 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776102857; cv=none; b=T+vHMAA2d4nYFeFGiNoUHcN0YoG/1sB7RRAGraal+cACqcJwKq7+T/Bgn8vbq5gdwEcOT7zTjhA0pbgyzFlva7CKgfA/Hp98HLLkhBE4406eXgo+rVDvrdVSNLJXazSDJwB45wn++cR62X5iBbzgpm2wt0NknIT/t3KSkoaS0CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776102857; c=relaxed/simple;
	bh=0HcM3PlrgFDJr5rA0SFgfUokTNodUWSQjnPwagfLlyA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XO7LhAkZx4MjEIF8rIBET+PG9bCRo/bopU0uFemw971W9CJIb4Qu6sSYJZGQc5VQtTgtlBCIzqkeuRVre3uqSl3lvjMDFz0gYAA+BU592t17vtJ+/iVPietWE3w8nniLCpI+wjcZ0detR0qIOtrS+l8V+nueza80i+32hyQHxwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZYNsiF3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZYNsiF3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918CEC2BCB0;
	Mon, 13 Apr 2026 17:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776102856;
	bh=0HcM3PlrgFDJr5rA0SFgfUokTNodUWSQjnPwagfLlyA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gZYNsiF3oM3dYrlDHWgBm0F+/XKPRJdyGsViQ4VvQG8xMgCLDJHY8HH3tCHc3n61D
	 fhwMI2yI7eQLO0Cd9xRXoVveYiqQKr7xKmU8OdO+Hig3oEcg3YcWJqT44cL3bgEjLZ
	 sOLyWCFnhbPh4J1x0NOLyaUJBhYR3N7r+h36pdbsfbUshaiyjfVllQyZ56JK/Vn9yq
	 YVdBrkFjFz1OpewbbNoZFaA70lPunA66ndPf9SCkGyMNzyhBjMXdfRHBcreHBtNpMd
	 EnEKPTIJZwg8bhA8Del5cWuCRWZAJ+PMvrZYFCGBc6JCVGf5EPpUw9M9pfxhJUdD1p
	 5/OxRpT6g7qxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD3C3809A8A;
	Mon, 13 Apr 2026 17:53:49 +0000 (UTC)
Subject: Re: [GIT PULL 04/12 for v7.1] vfs integrity
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260410-vfs-integrity-v71-caf8be59f7dd@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner> <20260410-vfs-integrity-v71-caf8be59f7dd@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260410-vfs-integrity-v71-caf8be59f7dd@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.integrity
X-PR-Tracked-Commit-Id: 1b63f91d1c9013629fb2005ace48b7aeead32330
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f00132132937ca01a99feaf8985109a9087c9ff
Message-Id: <177610282768.473774.1768043151906891928.pr-tracker-bot@kernel.org>
Date: Mon, 13 Apr 2026 17:53:47 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Apr 2026 17:17:13 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.integrity

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f00132132937ca01a99feaf8985109a9087c9ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
