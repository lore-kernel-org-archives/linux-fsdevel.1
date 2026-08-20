Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987E23988F1
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255880; cv=none; b=IA7U2vQCGWJUYJieX+E7qC3T7O4ckCNDDot5YBb1J7yDroyEx4saCCVjySikftGnAXs4EN6Hf0k84u7mgUV0mJZQLj+aOyuv3Wq2izAqtfJp+UGnHLE6OOTAvUwGC2hkFE4WizHXRDl6Bph2c+SDhw8lX0e61VfEWGm+kVdsMv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255880; c=relaxed/simple;
	bh=LuSDVTNzm5BU7rwRxWxtv9YG0wij//kc4v49jZVQrGE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YMDMNl8OP4LoqLSTM0kT2UE8r0PEZMOlUmgcqXzWG4GLYmjtT9HZnFGnI1GgwZwGHKkbC9R4s3w+PPaBrzNLBHYcRg/cx9dE27a59YUvXQjwSq4cJRXCTJgTAhIJE5O6yMR4RBdAJ5wGbUhponMxz7VykqTck6H3DO9ANz922WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDWH0h9M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDWH0h9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281301F000E9;
	Thu, 20 Aug 2026 19:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787255877;
	bh=vcc47ZbfaCXzx5DTvjZT/Eh6R/BWpC1lXxTZyDAR6Kw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=QDWH0h9Mly2TkUaoeD0VO2LD609OvGYbr7y00PeIBY1/NtZteaJJTCxzX3AohOSfh
	 JPcpQRXZgjGVLKUH5pd3AZfxqTnWsymAZAJG4vZtNE0YaPHg2UpBsGQ6rmIv+fc/X3
	 rO5T/pmJjM/lOXGPTeedHOrDSI3RYTkSbzzJ57ywTcoEQKkEhRijsFmIAGahPeIhPk
	 sLO+o6BiO/uFQJ90FtHeZpt3iN/qFtT2KtUNRdUsfP14Hs3+VzyJwaLDpYv4kEy67H
	 Zo2UkzjbwO4G6+IrTExyLISPCnStIAbqcx9vHeNMoYbcxVr0tkVIsUG7asffFKTfty
	 CGkpkqklbXjdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93E6A392445B;
	Thu, 20 Aug 2026 19:57:08 +0000 (UTC)
Subject: Re: [GIT PULL] ext2, udf, isofs, and quota fixes for 7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <tphtwc3dv7cvvj2eviegoqhifpsyfoukrsm24b4psba4atrewo@gmuw7mnqcdrp>
References: <tphtwc3dv7cvvj2eviegoqhifpsyfoukrsm24b4psba4atrewo@gmuw7mnqcdrp>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <tphtwc3dv7cvvj2eviegoqhifpsyfoukrsm24b4psba4atrewo@gmuw7mnqcdrp>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v7.3-rc1
X-PR-Tracked-Commit-Id: 62333e480d12ab186f89fe2725b372d12f72d5eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9328b3b03bdce05f660dbf33a4183716a64e304f
Message-Id: <178725582732.459220.15312433691985284119.pr-tracker-bot@kernel.org>
Date: Thu, 20 Aug 2026 19:57:07 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 19 Aug 2026 17:03:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v7.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9328b3b03bdce05f660dbf33a4183716a64e304f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
