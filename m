Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBA8437464;
	Mon,  3 Aug 2026 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785785374; cv=none; b=Bpu7k1WAc3JLPsvvM4DbwqO58ywbK1qRjTLx7kS2bos07AEA3FFkXj926fY3Chh4dbf+cHULr/To7sxZeMDYE/CpM0vbzaK/J4i3MdR3PPZ0CVaPUl0GFTXRjWhhKSxqQ1RZ4w6z1BPDD53dzp9Qr03avSQkweJSQZV9mO3dPzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785785374; c=relaxed/simple;
	bh=qJYPxEYA+yLh6WwzDKE/0mIOq9oJ2oayhd+y4b62iZ4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IpOIsNBRhMcD7jmGE1BnehCMfIEiq7tsqZNwpKb66OoG1Wqj0ywrN/tBKmuWyLy+P94RXP2P2P2ecQdLcbZDu087jIwbNAYMJUO1IFUgOGfQ5JwAO6vJ6RWLHWHpTpOKkVbXy//vspeiNvZPkn6er9aTkvarkpVnDeyKkuJ+jq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXoYI5/5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXoYI5/5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3AF1F000E9;
	Mon,  3 Aug 2026 19:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785785371;
	bh=WqJYgf5Dk64XX5LThWT1AftXHz7Jo1KY98bN2VgKhVs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=GXoYI5/5uYLAEjyjbie9LppvNNoYPMiP9vSqJWCvU0/kX23QG2lPvQzkvr6/xJfs+
	 7NlCOn9hW9NNBnEnQIhKYFV973mjy5XpSaMB3xTqDWfIGEARlVaKu9JLmRgyw9vwSM
	 M/FGJw4idIOdwgfSIOL7tHt+ye8a+Sk6yXb6jktEk2hgv/+9F33qb/VleIVIEo/Tdv
	 IP5qMSxICwg2H35B6zN2jSDfvpu2806WlQRuLu5++WbwkmbiDCMSPDy+exKBXX2LR1
	 msVVEm1mYWga6CS05yqQMRHe4fObV5ePB59wy+AmeJa64NHxj+KvSUQb3xVUWMBRbB
	 S3Pb7Bm2nNg8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198C5380A957;
	Mon,  3 Aug 2026 19:28:54 +0000 (UTC)
Subject: Re: [GIT PULL] fsverity fix for v7.2-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260803183304.GB2062@quark>
References: <20260803183304.GB2062@quark>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260803183304.GB2062@quark>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: d2f96bcb89d36d488a10e3bcf819b98536968286
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 848acc8ffe1b7cd5f1bf427b93069becfebc2c9d
Message-Id: <178578533264.2798434.147028201894410979.pr-tracker-bot@kernel.org>
Date: Mon, 03 Aug 2026 19:28:52 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Andrey Albershteyn <aalbersh@kernel.org>, Christoph Hellwig <hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 3 Aug 2026 11:33:04 -0700:

> https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/848acc8ffe1b7cd5f1bf427b93069becfebc2c9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
