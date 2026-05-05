Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC400175A6E;
	Tue,  5 May 2026 05:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958495; cv=none; b=pfJyMYfydRn9wvTUb+Iw7etwJ/6S7uY1fz7SBG6TDH4Y1gYTnUKMjX/pjuv/QUcK4Npf2Sf5lo58MASih/NZyHSX2eqLTra1487xbNue5rm0WaWPLjKxkSpgBzl6yW24J5uuArC26EfWKj7FbDDeDehE1ZeVUGstyTHATMNaEig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958495; c=relaxed/simple;
	bh=/ZJZKBaq7O387rInC/N1nA3zu0tjFjaxr2LdeJEzKvw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gbt5J2QfwBbkb3pbvMfLZIZUSQiUyv531GxuIFslYLPX93PfhNNxpBZge+IqRWa972E696AU0SfEK7p3dqlZfN7iGDGnvUHQexaJ7bdvn4Loset72AmTac2OPJjk3DEgKGCd7lrHEC9I2eb5hz5b4byHuLTuADpGL/7HNifHujM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHdGDLEA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHdGDLEA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67731C2BCB4;
	Tue,  5 May 2026 05:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777958495;
	bh=/ZJZKBaq7O387rInC/N1nA3zu0tjFjaxr2LdeJEzKvw=;
	h=Date:From:To:Cc:Subject:From;
	b=nHdGDLEADcETtWdusmibrsGb0wm9QJX8mTO/6Afno9ztnYr3E0yPVg2kZJtznKkV7
	 t8JZIRRrFwD0kvn9SuLarx+gp4Khc4O4ActGdR2vG8eeDS6JDNfaqZdqQF9OJWYnMs
	 a0IGc1RZPBKwdvSBtf4oaDtx51K80vgdsGqVGtyt+RTyMunP2q7RUi4/FVOzBpdgEP
	 72brHuUjDzEFNT4EnijTsoEyIZKYj+DIYjl6w626a5uDEO43Fwv68DqGDd9ImYPNxN
	 ss0HJwMIsiuG29r9iCBVD6q+xJOW5rA/6PaJyRu6xRS75BsEr/ylBpY9Ol8RR0fdYG
	 lHJfeEmAoWrSA==
Date: Mon, 4 May 2026 22:21:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com
Cc: linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
	miklos@szeredi.hu, neal@gompa.dev, joannelkoong@gmail.com
Subject: [PATCHBOMB] libfuse: various fixes for new mount code
Message-ID: <20260505052133.GR7765@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bernd,

The two patchsets under this message try to fix various bugs in both
yours and my new fuse filesystem mounting code.

The first patchset branches off the "fuse-service-container" branch on
your private github account and fixes a couple of problems I noticed in
the new SYNC_INIT + fsmount code.  I think they should be applied to
libfuse master sooner than later since all that stuff is in master now.

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git/log/?h=fuse-mount-api-fixes_2026-05-04

The second patchset contains some latent bugfixes that I put into my
branch after you pulled my series *and* what I hope are sufficient
corrections to resolve all the new cppcheck complaints that you sent me.
I have now managed to (I think) replicate your setup exactly enough that
I can run it here independently.

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git/log/?h=fuse-service-container-fixes_2026-05-04

--D
