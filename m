Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503B933BBBD;
	Sat,  4 Apr 2026 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775283783; cv=none; b=iDiKWradpRIiP3wFmU9Ezm3O+NfOuvgPljk15+bFN0NKQqUKTVuKHzmMlzxranz0//EeNhVtaQXsiSTq94HRq6VSiXQ9clgA/0NIAubU4jcbnhRI9Skvz2oUf2f2/+Qe8982zk78YeHAvNBFOUxUePTMpCsW7jgq10ZECd1SgxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775283783; c=relaxed/simple;
	bh=iNnj5HZg++VmJ8JOVVzYwT6qH37ngG4hSW37NpcwluU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhCdUDgvExE76L+jTkU+WyzB+ft01oiEYJ7eYwuRkkCJaLobV9e13sKpz2UpXNFV4RMe49P7AhJiZE3nPGDWZTOBKdyRic7x2Aj/Ut/ynVUZREOg8ptQbZI8mhl7E2nUZlwFOMdDhpOhT3EjmkoZEvp7B0OmGwRDhe6l8f5hL4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MCavQK+E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MCavQK+E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67991C19423;
	Sat,  4 Apr 2026 06:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775283782;
	bh=iNnj5HZg++VmJ8JOVVzYwT6qH37ngG4hSW37NpcwluU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MCavQK+E7ntcMvzed7iOIiYphf12rgO2yG/mhea3c0ksZu6SOirNPtZG/rnVVLNvR
	 6ybmv2PFH9ep+c8SJG1IzJ8TVL36F4cUeCw2Oc75T3+Y2mtSb1YEso5JVY6T/AHlgD
	 BeanM1h0P4y4PZ6ABuhxoxVb1Dms3JoP833Jktho=
Date: Sat, 4 Apr 2026 08:23:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tomasz Kramkowski <tomasz@kramkow.ski>
Cc: stable@vger.kernel.org, Alva Lan <alvalan9@foxmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] xattr: restore file descriptor checks
Message-ID: <2026040419-volumes-femur-731d@gregkh>
References: <20260403230636.344097-1-tomasz@kramkow.ski>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403230636.344097-1-tomasz@kramkow.ski>

On Sat, Apr 04, 2026 at 12:06:36AM +0100, Tomasz Kramkowski wrote:
> This patch restores the checks incorrectly removed by commit
> 5a1e865e5106 ("xattr: switch to CLASS(fd)").
> 
> That commit was an attempt backport an upstream commit which had
> modified but did not remove the checks to see if the passed file
> descriptor referred to an open file. This seems to have resulted in the
> backport removing the checks.
> 
> This leads to a kernel panic when calling `fgetxattr`, `flistxattr`,
> `fremovexattr`, and `fsetxattr` with a file descriptor which does not
> refer to an open file.
> 
> Tested in qemu.
> 
> Signed-off-by: Tomasz Kramkowski <tomasz@kramkow.ski>

Ah crap, I should have caught that in the original backport, sorry about
that.

Should we just revert the original and wait for a "fixed" version to
show up instead?

thanks,

greg k-h
