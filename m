Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4407261D
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 11:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769167392; cv=none; b=o6V6x9/S1JJqEy4OE9OQ6HnIWJfsHWymRg4fGo7WmyOF4W+F/EeDR3qYPyiVA67nSbvVDCKfnQCQDcvP1elzeDYio5SZShazC3FLX/at9/hIatJdySqm9qRf0Tcy45O3g2HLy7E2sEPM+VWmEzaSwa1R783PgEK0ealRthpXxhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769167392; c=relaxed/simple;
	bh=JihW3igFWhujqeFtFYSXl0VTt6j1YiBd0ixrhS2Tvsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUxWD3EHa+/b7JL69Rz8lEUfFfYBlwpyfvmKEAflXL+kjaXmM1Ve2a8vDeg37bkLbDVxId45fq//ROOOZhYXdZEO35NsXMSEv5xfFTPMcwz/Ci2If/KcppAVpsQjOfc5cczEhgQ1uVWvIoe4vsbVI0y/Lec7hagOyIqaqkNfSeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yo8Pl7rI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yo8Pl7rI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB8EC4CEF1;
	Fri, 23 Jan 2026 11:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769167391;
	bh=JihW3igFWhujqeFtFYSXl0VTt6j1YiBd0ixrhS2Tvsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yo8Pl7rIbkR2hEv/H1wPvZtoEnNSEU+lSy5yiLmRSVWy1woWZl26aPoBYp74aZrfg
	 cAlvgO3BqBTIQrOSjehEaeUbjSBJLdsZRM9obfTnVzTfkSuRGfdSg4TLzS5/Xk+xnc
	 TGEmn8mGNrWRkYvyXFNRnhw5KhY1bWnV1NAih4uXlirONL4xqIuPPQuMWLlqeBpBk/
	 DegZM1ndFO4iXZFQjXyGul/RGaBMAf1xDztBMQtIj3Re00WLyXqMhNAJcU11udTNZN
	 O0z6jLAT7s6+4TmOClsS+ozn7Qil8MZMFi/2GZy0YlFvDvUf8K4A1WNkJZXw2GyClm
	 xb+X1a5WUBuyg==
Date: Fri, 23 Jan 2026 12:23:08 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2 0/3] fsnotify: Independent inode tracking
Message-ID: <20260123-leiden-kampieren-3c760104d199@brauner>
References: <20260120131830.21836-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260120131830.21836-1-jack@suse.cz>

On Tue, Jan 20, 2026 at 02:23:08PM +0100, Jan Kara wrote:
> Hello!
> 
> Here is another revision of the patch set implementing independent tracking of
> inodes that have any notification marks attached through a linked list of mark
> connectors used for inodes. We then use this list to destroy all inode marks
> for a superblock during unmount instead of iterating all inodes on a
> superblock. With this more efficient way of destroying all inode marks we can
> move this destruction earlier in generic_shutdown_super() before dcache (and
> sb->s_root in particular) is pruned which fixes races between fsnotify events
> encoding handles and accessing sb->s_root after generic_shutdown_super() has
> freed them.

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
