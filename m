Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197443242D7;
	Wed, 22 Apr 2026 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776839740; cv=none; b=KwlZKNu6wkVUE0E6ivlI6z6pxKSDRKMphGBGv8sQVKsyn2Rb9G6zQh1+zN2FGkmO5jSaextaL4UncAyLqQ9QrNjBWT+pZvdIpqD4GCJw56UmMhYUuMhFPRa9YQc6Nr9qTXnhdh3ujBe4w4TVo0vaXB6ypN92iyEJj2/8yc15Nt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776839740; c=relaxed/simple;
	bh=OJaZyaNzteenGHEeB2eKLAN5bDYx8tt3ZUVWPMKmRo0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cOSBtxVE6DYJqDo7EqlaGe5GPwCENU9lQ3GCxyGlKtHMFLu4a+pTRKlJtmGVXACKKW+zt5ofuJM3whklpI+lBCBroStJL+UZij3UKOYiFM9yXDN+YugQJUoRWv6vzOfgGiP8vWtEyzm8kenqYbKu6cvMrt4+Y3oxgoHEMe3gpRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSLb27Va; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSLb27Va"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D53AC2BCB3;
	Wed, 22 Apr 2026 06:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776839739;
	bh=OJaZyaNzteenGHEeB2eKLAN5bDYx8tt3ZUVWPMKmRo0=;
	h=Date:From:To:Cc:Subject:From;
	b=FSLb27VaepqKcE9VucX1NC4o6knCMm2p6r1bCXGDvZYM1clrRFoV4GczYfU5r1EkZ
	 EauMlYEirlpp4B1ooyxRTxs0uFBzluPgCaxP5h81sk7a7dCB3UWBhmKTjotNlPYyfg
	 8TSGuRgIYg3tm3ZOp7m5poGCIcLedetn8YKgyFizeY+cuFkOTohH+krnl4ElP/Kexf
	 ZU16CltEGJroQGrrwtwnY+EHjxwMtky83oc+A7aftkm/tOGWVL+rfwpSkvqdd3iOCH
	 1ZDBnN1MoTBjKDjN+TRQO0mq/B0H6peJdHkvA+zNovN4kahsymWjzPQECUWZYq2748
	 O9kuOpcI6Fo3A==
Date: Tue, 21 Apr 2026 23:35:38 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: fuse-devel <fuse-devel@lists.linux.dev>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Bernd Schubert <bernd@bsbernd.com>
Subject: libfuse accepts subtypes with slashes in them??
Message-ID: <20260422063538.GD7739@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey everyone,

So today I noticed that this happens on Debian 13:

$ mount -t fuse./bin/ls /root/ /etc/shadow
ls: cannot access 'rw,dev,suid': No such file or directory
-rw-r----- 1 root 1345 Nov 18 10:38 /etc/shadow

ls: cannot open directory '/root': Permission denied

Uh... is that intentional?  It looks as though mount does:

execve("/sbin/mount.fuse", ["/sbin/mount.fuse", "/root", "/etc/shadow", "-o", "rw", "-t", "fuse./bin/ls"]...)

and then mount.fuse just trims off everything after the "fuse." and
does:

execve("/bin/sh", ["/bin/sh", "-c", "'/bin/ls' '/root' '/etc/shadow' '-o' 'rw,dev,suid'"]...)

with the odd output that you see above.  Is that supposed to happen?
Or should libfuse reject subtypes with path separators?

--D
