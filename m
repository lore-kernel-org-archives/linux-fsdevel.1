Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495B9383305
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341059; cv=none; b=A7vk7ExEMEr69ihkNaamDLEo4nUNCPudIC2M4z0Y8NzxOZDwtzu+MqnGpKHMj53wuJEidIBvqcIVjYVZMfA4wXOjArydW5L4odlocN8qGDldhVsEysqp635WQ5V7O5Ci9dNobbn/D7lXL5ZvPudedOVqKxJMCR4MZDwhHaLRq18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341059; c=relaxed/simple;
	bh=6x1BUdw6yVtnhFa+nwDC1vBpo3HUebWgie6OvRQvY1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CF1CokdXkSeFrutpbIWmW4RYskXp5r4aPUY4kVpjISSHF0fLyzTPIqweFQStiT2K937bw2kC9FEGfyPh1ry3GYdOMUEC/4KreQSVxn6/sGm7DAQvkr0occKu96xOTqnCG92NAWduNPyVdjG/WIXEon8zCHkENoahaQVr8dxTjMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbT+n2i5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbT+n2i5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878E41F000C4;
	Sun, 18 Oct 2026 16:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792341058;
	bh=V5ZX8pi5ujpw5zTKzYs7E/a15DUkelvrdb0cp0d83gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nbT+n2i5H629u3B3EW5ydcTpnHQiN6vjXCPjnaurHPjHvXkfLJfv3GOqPsXO3+POs
	 kRGfYV15LHcxxLu8Hcn7uBU5HgF7wTiPwDdWtoyT9OizJEl35dzSxaBrw/45CTuxWM
	 p+bnVSvYEcnTQN/e2yxPam6H+7tVZdInHj/UAH+S93Suildz3S8nB42Wq4tQ3aIePM
	 Bc84smJ1oKHizGlRwD2QZ1JAFP6bEPnzRVaXDAHgnewnIC33WqNLnb78Q4lw+gPZjO
	 u0BJY+LUTyAcfvg7y3zWuqNglG79WpBCPvCvWJOGHAkbs59NTJ3gUJlpcp41wHbBYH
	 9UDgQkP+vMmIw==
Date: Sun, 18 Oct 2026 18:30:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 2/3] namespace: rework connected mounts
Message-ID: <20261018-ausrufen-triangel-weckruf-baf5c3e6df2d@brauner>
References: <20261002-work-mount-cover-v1-0-232a8f52b43c@kernel.org>
 <20261002-work-mount-cover-v1-2-232a8f52b43c@kernel.org>
 <20261018035435.GD3535232@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261018035435.GD3535232@ZenIV>

On Sun, Oct 18, 2026 at 04:54:35AM +0100, Al Viro wrote:
> BTW, at that point we are left with only one caller of __umount_mnt(), always
> with &ex_mountpoints as the second argument.

I can fold that into umount_mnt() for 7.4.

-- 
