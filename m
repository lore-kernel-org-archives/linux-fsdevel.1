Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09363A1E71
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128464; cv=none; b=fNE4sPup9w+RZ/iZmn20wPbZNCRVNppkFt3hOSsVYIrxgC8KC6dxXNVdXNnTlZuPb4rtVwL1vj28GsQN7zxjGi2lvug9Rzl9m++ugI4x6ZWpEY/wSAOImewgBbDhljTsTW2cei3cegdlTG6zD3zmxcrjTpXQ8Wz4m7DDoe6jUHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128464; c=relaxed/simple;
	bh=ciYbSRE4yrngNqJiyUtftzvJA029wGFod1hMuNHg9ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDt0GcUYq+0Mklp4lM2xOF1tA2q2hp4az9qH9VWvuAOmi3N0e+tMuB3WYUKCXCh26LMuMwmxgrTRG6eg7Ss/Rz9vICBpSEKAYY9PM7S48KAK7DNHgAOYPO0BrbmXlIbr4k909L7sv5E4SIwdum7BA5Q2aS9L3Asr9s0xOS0FR9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRiw35VX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRiw35VX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4541BC116D0;
	Tue,  3 Feb 2026 14:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770128464;
	bh=ciYbSRE4yrngNqJiyUtftzvJA029wGFod1hMuNHg9ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gRiw35VXJ7TcCD/er2bAef8ZBskwKTn26rqXrA6nLfQLsvfwq4zLLbh2GS/KbxIJw
	 qW2OPBtFSUsRv6yLhkqmHxWM+GV3GKTYl/qx/uQTh++3TBB1ASlj01sD6Kryp+EtP5
	 QsN6rLHmsvE4hAADQkCEvgKT9QQ7RVTDiVjhZNNf+2Lga4RcqnXSfCGqlaIKiOnwQt
	 KVYEWuC1PXseAa5ahAkpIfBpJmd2xlW58HXvf+CgsQ+Iz4S1vfz47iAE9phlKMvkLW
	 +z7p35OzJlLipDQ8Yezs4EhsWZD/dkHOTDodTz99FFSY69Jr/QVsG92O1ZhHTSPJP8
	 9VFtSBufM92/w==
Date: Tue, 3 Feb 2026 15:20:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, John Groves <John@groves.net>, 
	Bernd Schubert <bernd@bsbernd.com>, Horst Birthelmer <horst@birthelmer.de>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Message-ID: <20260203-balkon-folgt-67ee66f5d271@brauner>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <CAOQ4uxjEdJHjbfCFM364V=tBrEyczYvzo-b-Xo0UPOCA2cnPGQ@mail.gmail.com>
 <87cy2myvyu.fsf@wotan.olymp>
 <CAOQ4uxjKHptXXCJzpwU6jvGKiqTuRBOSesmpzGGUTgcJqW_gbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjKHptXXCJzpwU6jvGKiqTuRBOSesmpzGGUTgcJqW_gbQ@mail.gmail.com>

> Restartability and stable FUSE handles is one of the requirements

I'd be interested in this.
