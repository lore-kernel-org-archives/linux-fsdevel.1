Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA422BEFF6;
	Tue, 14 Apr 2026 00:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126623; cv=none; b=RGTC599pDSwEIl8JBCJFT+7D/oSqQewh0EqEdO9T15Q4Ew1tBz9NnUQstGUcPPKxWENeO++YLvC4Poja+Uzaf7oGn1wChPqTZa5xPV9OG5wGQaD3heji+BDq6x4Py+wJKZvB/8KKNcbZJ8gVerNwCqTW6GjFYRsswl3mLHS51BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126623; c=relaxed/simple;
	bh=gAiZEAG98Qitjepi1U0P/r/ZDfVHEXlUqbQMJ0WVBMw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=arsl7uBd0Ag5RZAdbqljHL7wJdrOq0bR1rZS/OP7oTnANksaOkZwA+j8UAW9vuPzEGa0JCehZRVb0UdfFMSkaME9P9bUlyjrPhdbYK5/ppY9Tct0ZJ71MKdqL0ZgOvJE0wNSdqMKTdCkeL1eZv4CvcipT1+9+xyeUVZuQIgLS3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYmJHHHQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYmJHHHQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C972EC2BCB6;
	Tue, 14 Apr 2026 00:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776126622;
	bh=gAiZEAG98Qitjepi1U0P/r/ZDfVHEXlUqbQMJ0WVBMw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YYmJHHHQ8rtViIVmuNA+RFIJrkYEXYrB0YC7+/f2zmrCywP+g/t1X2wpEY+0NAHsQ
	 KP434V1pavj4X+RA9J6jj2fvtFYShrV2YOXoPUtF4iSKfq+itP1BlNfw/LfpMMfhmC
	 2Znns7aEUhpP76wlQtAyVPwx6KMDmuEMj5z49Buh3TH7CB3dpi+/HzEe0YYaNIBzEk
	 sgWCXt4HWFQM8h/dtUz04ceDakLcsHIl7iDYgBGbVg87TO8dxkkDL7j7hz9U99VUgs
	 8yPO+WtC+KG87K96IbiZzyRL0Uk5+8JMJjinRba7ib1h1zMxIEjn5kMi4QRNstIfz7
	 85ss2UkQ6vzpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD243809A0B;
	Tue, 14 Apr 2026 00:29:55 +0000 (UTC)
Subject: Re: [GIT PULL] hfs/hfsplus changes for 7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <8a4699567ef82973224fe25d372c0831a46b189e.camel@dubeyko.com>
References: <8a4699567ef82973224fe25d372c0831a46b189e.camel@dubeyko.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8a4699567ef82973224fe25d372c0831a46b189e.camel@dubeyko.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git tags/hfs-v7.1-tag1
X-PR-Tracked-Commit-Id: c1307d18caa819ddc28459d858eb38fdd6c3f8a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d9981429aa61c31e67371ac09e7dbba6b59de14
Message-Id: <177612659385.618768.16050163720921302691.pr-tracker-bot@kernel.org>
Date: Tue, 14 Apr 2026 00:29:53 +0000
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, kartikey406@gmail.com, shardul.b@mpiricsoftware.com, zilin@seu.edu.cn, Slava.Dubeyko@ibm.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Apr 2026 15:05:38 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git tags/hfs-v7.1-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d9981429aa61c31e67371ac09e7dbba6b59de14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
