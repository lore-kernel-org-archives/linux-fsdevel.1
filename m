Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95517359A91;
	Mon, 13 Apr 2026 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776102853; cv=none; b=oTI6qdhn0oNEVANw0QukIgRTdrN05OF4pM8d68hOG18JWPbIHRXyozW+02LYqMkI5Ebp8KiaQWFkusUHfS4fqRV6URMlYyJjlo32PNm9Erdx4Eyvpt/hyqXKn61XF8wMfuwQUWL1GvFhmYaj+pLJy+IrJo1IShGUptZscEcNB/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776102853; c=relaxed/simple;
	bh=dThqspuxVZvfgiHJYe+mZrzNwdp9FiawYnVaSnlqVP0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Je6SUUC/pulHpOlFHR2WXXYCClicZgf/DXKGK+NnyATye6yisYXx29uEi+gjnTEjb6UP+2q8oENBcIj5SD1MXEVt/iYCfUZSWdP7b00Qc+Z16wQ8lFEM3NDH4uO4jLI1KtkUYXFol75gprGdpMY1JzniV4Y4qig0Iao+i0JL+xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lsx6zkM8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lsx6zkM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5EEC2BCB0;
	Mon, 13 Apr 2026 17:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776102853;
	bh=dThqspuxVZvfgiHJYe+mZrzNwdp9FiawYnVaSnlqVP0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Lsx6zkM88DSk6U1HY1LosIvuoqVtVun9ELE9aO6K60SO0WLUPlhNMSYlWCuWXqhh0
	 S8hmS+8WKq5CgzAeMycLqn7FITIcJNH3eXskt5ThE+g2PqexQj08J2Q8nZsKpkhDxP
	 6khPWfaicZOa4iC45mCYKLn+wARxSSPlssElUZVSeetvjYbj4RRxIQxJ8ot+k09OfM
	 NwZkZ7fapW5HTzZsfz8lnsayVIeqsb9gCN5JJE5Mrvk4Nc5q+OGR3CmfwTkvBjCCGj
	 nhIFZg4j/ntzqQCFFirpunozK5hp1vkScv5QrWgJ5ABdmciUX/OEafi1/tn7wU2UPk
	 FKRmOkyS6ZeHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D2F3809A8A;
	Mon, 13 Apr 2026 17:53:46 +0000 (UTC)
Subject: Re: [GIT PULL 02/12 for v7.1] vfs xattr
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260410-vfs-xattr-v71-9b287a50d751@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner> <20260410-vfs-xattr-v71-9b287a50d751@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260410-vfs-xattr-v71-9b287a50d751@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.xattr
X-PR-Tracked-Commit-Id: 98779186aa0b3367489a87c6d8bc0911f577444e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8db08110cbeff12a1f3990a31730936b092f62b
Message-Id: <177610282468.473774.2761107617000637469.pr-tracker-bot@kernel.org>
Date: Mon, 13 Apr 2026 17:53:44 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Apr 2026 17:16:30 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.xattr

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8db08110cbeff12a1f3990a31730936b092f62b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
