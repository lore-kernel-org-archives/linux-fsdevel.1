Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51468351C3D;
	Thu,  7 May 2026 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192028; cv=none; b=sjoJsZkJfZSQ4YSvDbpAEp1HKoPy1W6MLXhX+5TI7tJScNuRpNvZEn6LZLHNTHzFYB5BUDRz0UR2KheuZpmM6DaJA5kXyGRmOowHqpwOS71JV135iCKNrnEahO42vL3+m1HIpjVyK8mF8QERGRtcKyoyOD+3OPY7MQNm7gluab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192028; c=relaxed/simple;
	bh=yn1WG7eMr9u7jMzUTtnhGeXQyq7DNw8xxrLSGNXHwJE=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=StZrNwWOXbtuZHRh0gM+eV5x43r8bDVKNQF/gpze8eZeCtSHp1eSJXYRm9uv6Ddy15x+F5LxCt/4vf2CJVaAgS5UQYj/OhRLmF3n5/kJJqgmUwIxgbAxrel3PC51y6NoDQN04SoZTvGWFTdqAK/VbuQqeYQ4lPhJdVkfpKnyPhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2gcG2bL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2gcG2bL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDD8C2BCB2;
	Thu,  7 May 2026 22:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778192028;
	bh=yn1WG7eMr9u7jMzUTtnhGeXQyq7DNw8xxrLSGNXHwJE=;
	h=Date:Subject:From:To:Cc:From;
	b=m2gcG2bLCsKKPrVBOSvFPoq1l7Exzbxzbo83lE8ywCdCHMumiOUnT2Jodmf2v3PE6
	 hPKRTqhp1jv6sJKaamav3h+/FgnLi4EOc52EwBwZlZyGCeQOQz0pKWCcLDA/NoCrFK
	 oNWDRLpMj3x11JRlKG5zZa1+Nh7x5xzcvAslH4m43RPzvo6NmtrzEDJGZ6YFgNM0Vv
	 QPcXnM15J/0pmPbi6r85xAfqVKtaldPX7y35bMNxI7sY+PB5k4F/GIh9El8co8+It8
	 qyd4iLzcu8FJOZaERHCeSFVXMLg40IV4H/ikGCjFkMs+kBXYlysD6NGcB8CuuNk3FV
	 jY1ZAROUJVCBg==
Date: Thu, 07 May 2026 15:13:47 -0700
Subject: [PATCHSET 1/2] libfuse: new mount API and SYNC_INIT fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, fuse-devel@lists.linux.dev,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org
Message-ID: <177819197881.3490692.13850589276777261250.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Here's a collection of bug fixes and cppcheck cleanups for the new mount
API code and the new SYNC_INIT code that landed in main recently.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D
---
Commits in this patchset:
 * mount_util: fix mount_flags entries for MS_RDONLY
---
 lib/mount_util.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

