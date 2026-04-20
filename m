Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2079E3ACEE6;
	Mon, 20 Apr 2026 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776708850; cv=none; b=sIXDx42t5uU+/3r0SephFkqUbZr2FaGeuUHW69dZ0vRvwC2f0JKubEumr11hObNYpJeILbQ5VoVrYaEZtSkNvlSy48WUReohG20X9cHU9VVgD3iQXWlCFjK0RZhrQ5BTG6Pwr+LIK4H/4QufoRF+YwRS3NmUzAl1UpQcGBw5uUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776708850; c=relaxed/simple;
	bh=kXbee9Xe9cv2JQfLCnZ6wX7+voLrBeBKAYuflKNrJx4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=A7syq+rQihhD5Xhwo8PvOP4eExDzkMY+mQwIpn/STnBjd8hxacIYLusoCD0zeMpzTBucT/vTBMeg5jopChvaWfFstQTZyHI6ae2frXnJHlA4MLAm3Nv57qvU/vDDVpm/5CBVfRJ0pN5C2K/00ZR1EPm57oDP2mi1eoqSNyMicqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUkpXGrD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUkpXGrD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055CBC2BCB8;
	Mon, 20 Apr 2026 18:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776708850;
	bh=kXbee9Xe9cv2JQfLCnZ6wX7+voLrBeBKAYuflKNrJx4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SUkpXGrD3eiqrh8ymzOLM+eCQeVgNlU51QlWafPfmqUEwvNp4B7EMiPJGtGP2vS1k
	 cZjdnL9bTX1AuRgCZ3hT+VTh+lum5G9X7Meu548w+Dy6HteZ/fzaN6PC9TTiaJ/DCl
	 AwnwK8wUAqrwMHshRFvTUYqk3ZdQZTcirACCMc9T3XVeWgEpllw2wodf/OMIB9RRZs
	 8nRaYE96xCD2pF32l+06HlJo/M9mn43BDWh4D8BPmWaySfCE956aYa/ZWIg84PqMDj
	 6EKLR2IBCvRUeOYq69jt3BjmtNXzRuQPndB0FByHSnqws7o+sXJC0NUrgMpAd2wU2D
	 490qkPjBABPIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EEC393001F;
	Mon, 20 Apr 2026 18:13:35 +0000 (UTC)
Subject: Re: [GIT PULL] ntfs3: bugfixes for 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260420150756.6058-1-almaz.alexandrovich@paragon-software.com>
References: <20260420150756.6058-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260420150756.6058-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-Remote: https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_7.1
X-PR-Tracked-Commit-Id: 819bd270abf9de3b7f306e233054b85a07c47820
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5d1079c28a5bc6caa30ef4099ef04ed17d2c6aa
Message-Id: <177670881425.1799182.13714246587030358225.pr-tracker-bot@kernel.org>
Date: Mon, 20 Apr 2026 18:13:34 +0000
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: torvalds@linux-foundation.org, ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 0xkato <0xkkato@gmail.com>, Adarsh Das <adarshdas950@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Deepanshu Kartikey <kartikey406@gmail.com>, Edward Adam Davis <eadavis@qq.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>, Sun Jian <sun.jian.kdev@gmail.com>, Tobias Gaertner <tob.gaertner@me.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, Ziyi Guo <n7l8m4@u.northwestern.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 Apr 2026 17:07:56 +0200:

> https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_7.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5d1079c28a5bc6caa30ef4099ef04ed17d2c6aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
