Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578BA3AE6FE;
	Wed, 18 Mar 2026 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773826971; cv=none; b=h42SksF1b7jjXUdZzxQzi0uTdIJ7va7jaS78CFQXNKuRXci2kI/0z1KgridCsIVc+jZfAfR1NotzNyFdhA9dbLOPEo0CZ0x2yAnOeTvHCruQkNaYH8TemWn+UYSuTISUJDQhFJyYlqX/6IZ6kxCPyyrYP7Q4z5AxPlhmJ1PFEbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773826971; c=relaxed/simple;
	bh=CKeNqFctBKLrAJOvvwsSv6tOqmic43H39OVSJFb2AuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABH0r5I3ywJ64WirKIDCxCe83V/cIpovSclcwUYW4REspMAAWJcZorJPeoYLR7FG/XIRfwWprG/E2eRm5llXzJJe+Dzve/abgQ4PAq15K14vmGrfFGSdUTdtQJuSCMXbcsRzPi0eIEIfQ8qasdmqVjP86esILUqlSTeqcvZUhSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEqDl8F9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEqDl8F9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383B2C19421;
	Wed, 18 Mar 2026 09:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773826970;
	bh=CKeNqFctBKLrAJOvvwsSv6tOqmic43H39OVSJFb2AuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEqDl8F9ECAa49aCE0od+cUl6yF5Bvzuib+oHoIJ7rBwp4aowFoMMIqCbso1k+paK
	 cRYv6IItB7Y3dzxvsjEyst1Ia4dPORlOcoVB76asgbsFy/Tk76aXs0Puk/lnca0kbb
	 KxqBAnSkNojAS2gROrI35u0riQzCuWy7poIbJbAK3PJIBGPc8VEJf8iBCQs7EVfOoz
	 FqiQsmUPlgJzE0F+6MZ4/f/9fWw68/PWur0mnb0ViPS7m/qfa7hzpcFsiHPgJcBuOj
	 kRWIrSd2aZywb9ThqbTaoCGL0wKDrsJjytpykTnTsmgd1WS9RAQ1i6SsfMRUXfsdQJ
	 UK0/Rtudomd4g==
Date: Wed, 18 Mar 2026 10:42:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Hyungjung Joo <jhj140711@gmail.com>
Cc: jack@suse.cz, greg@kroah.com, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/mbcache: cancel shrink work before destroying the
 cache
Message-ID: <20260318-zerrieben-anhand-6eaa0bae9670@brauner>
References: <20260317054556.1821600-1-jhj140711@gmail.com>
 <20260317-inventar-wirksam-11bc2443fabc@brauner>
 <CAP_j_b85YA+h04Y91zWfmXH83+CQv5DiaJjbDF4DH+KPV4U-AA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP_j_b85YA+h04Y91zWfmXH83+CQv5DiaJjbDF4DH+KPV4U-AA@mail.gmail.com>

On Wed, Mar 18, 2026 at 12:43:19AM +0900, Hyungjung Joo wrote:
> 2026년 3월 17일 (화) PM 11:38, Christian Brauner <brauner@kernel.org>님이 작성:
> 
> > Pretty sure this is AI generated and it misses a Fixes: tag but otherwise looks
> > correct.
> 
> I'm sorry, forgot the fixes tag.
> Below is the correct fixes: tag.
> Fixes: c2f3140fe2ec
> Cc: stable@vger.kernel.org

I had already added that.
