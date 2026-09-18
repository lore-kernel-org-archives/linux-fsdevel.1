Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753A3BA236;
	Fri, 18 Sep 2026 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719533; cv=none; b=oXf+FNrWt8Bl+ffz4JOOPXFtIJoqkAMR7iftjK3/bBs9vZ9nBYawETzPqP8Fr+iJvypPLe9n7RWHF26RFCv5aTQRfsOvFGHrktlhkO/LRpn3vaqXYS5DLcSlEnyKQoe9h8O8QbFmbfrvY3vrM6jhI+6PD0hPWXjWjEKghNG2yIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719533; c=relaxed/simple;
	bh=xIkyt+rsxBQrjxE4J6MBaip0+x6YhdQctnUQuh35fzQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHzBrD7zCwSmD0bolw2FOB6BIBgoKkdfV7J/Hjz38QwxX1jbAMpuDEm5KrkgJyP/ny5icXqE8m2D97xH0RcPhg2jfG+AzEL7ulArh4ckKx41PRnWuCXHsjMsynZ8JQYRLzRHPw7DmFCPwIPdT4SeTQVRAvmdYJqeLl5UjFMX7fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFHZ/7bR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFHZ/7bR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEF81F000FF;
	Fri, 18 Sep 2026 08:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789719531;
	bh=lTXSk1AhQP1m1RvqcY6836SS4AdbuTT5yehopKmMvto=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=iFHZ/7bR7HbepdqG06GnR57FcWcGDV3OWr7IpGKPpEs2ib7802BMTqRyyfsBMNxlv
	 KKc6YFJINJAonzc4eZzvkyNypYxafEwNFqYEzLCu0QdKidln2asTkT6aBuo0Hb2E8J
	 y1wwTpbCF6ibgkSyWuA7O4UmhKQXJnea/yqxo3DwvUgOccguPP/h4d0AutDW5dzWcW
	 csQV5Y51Rm6YPsH1tW0JtPZAyU7o//objyM0U3c2VwhCkdtQjUkmTJlfkvU1sMQ5Rn
	 CRHcjLhHfQ/07esMGKNddF+ii8MezI9+PLskU69ZiY3hKxdYmfVycI7Z4zOBYZ9/pX
	 abgI1pQ8PMDMw==
Date: Fri, 18 Sep 2026 10:18:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: Re: [PATCH v6 00/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Message-ID: <20260918-anarchie-erdgeschichte-anmachen-be9535de01e4@brauner>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
 <20260917-feilschen-tauschen-fahnenflucht-7d41b8b49511@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917-feilschen-tauschen-fahnenflucht-7d41b8b49511@brauner>

On Thu, Sep 17, 2026 at 12:38:33PM +0200, Christian Brauner wrote:
> On Sun, 13 Sep 2026 20:50:04 +0200, Jori Koolstra wrote:
> > Finally got back from holiday. I know Neil is also attempting to make
> > changes to the same code paths as the O_CREAT|O_DIRECTORY series touch,
> > so I hope, now that I have a bit more time, that I can push this
> > forwards before I have to do more rebasing.
> > 
> > This series implements new semantics for the O_CREAT|O_DIRECTORY flag
> > combination for open*(2): perform a mkdir and open the resulting
> > directory; return a pinning fd (which mkdir does not).
> > 
> > [...]
> 
> Applied to the vfs-7.4.lookup branch of the vfs/vfs.git tree.
> Patches in the vfs-7.4.lookup branch should appear in linux-next soon.

Dropped after I reviewed it once more. But we're close, I think.
