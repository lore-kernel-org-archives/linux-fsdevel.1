Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3970C2D3EE5;
	Thu, 19 Feb 2026 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771490733; cv=none; b=AYfHWUC0UA99Xx8XmAzCIKy2DIx+SEzoTOGgOroDxUNr3yHOZM3j5bM5PFm+yGKnMd3cOiadQ9AqImfbsbFzQBcr5qf6pPSQcUwRFG7O4tVcNGqVImoIBf2HsjqoKrsdjQVW6tSKZxSq6GSNdqPc0voR9i7eukGrj9NLmvTp2tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771490733; c=relaxed/simple;
	bh=ECcpxB4DiSQl175a4Ykr8oGWvb9vQpGmjgW4Ls5WFFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYRBjhAZOOnDocecAIj7E7SW2/m8ynhKwBwnHTjrfs8yupHvL6TX5YvPW/UBXJQvQVFupJLw56vAutbfEFSSTLZxASkpABF/BOZod3YEJei79zSX2ktB5Mp0GILosCesiifPJupxSNbzjQ8Td2dgTWHMF7+fB+7Gt1keWdlRmFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erMly3+u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erMly3+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F356C4CEF7;
	Thu, 19 Feb 2026 08:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771490732;
	bh=ECcpxB4DiSQl175a4Ykr8oGWvb9vQpGmjgW4Ls5WFFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=erMly3+uE5MLHFvFQVX/nsF09bEuQp7MHes9vfSe6mEM8bXS1jzr1KXxNhn4YxvVC
	 P1qSwrfVSOSpKXdCun6Xkb3+x12Aug9QD9FaNTmSnWaPfZhgmMKQmxiqG05yrBKe5m
	 OJE2XjQDp79EhX3BxqG0rYO05twcmHklrj7vJ0XxUF9l3UxIXyR47hk4le17FWYWtz
	 WFYzfi3U8Fo1vRKBMlQ9G07bwVUQMuKgIW52I6b0xy2LFU26XbrHGYI1/qVdKjR/E4
	 iXl5Uzhht9TKYKNmWX3Xf/lKiWJUjjdhCMulAxwgLy0iaJ229DJXpZxZlaqISiXHCY
	 1a5xS2aZWcM0g==
Date: Thu, 19 Feb 2026 09:45:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Tom Spink <tspink@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] Introduce filesystem type tracking
Message-ID: <20260219-kavaliersdelikt-ansatz-9bdd1aa77326@brauner>
References: <1211196126-7442-1-git-send-email-tspink@gmail.com>
 <7b9198260805200606u6ebc2681o8af7a8eebc1cb96@mail.gmail.com>
 <20080520134306.GA28946@ZenIV.linux.org.uk>
 <20080520135732.GA30349@infradead.org>
 <20260218-goldrausch-hochmoderne-2b96018fbe5b@brauner>
 <aZakzr_QAY6a-dlB@infradead.org>
 <20260219-galaxie-sensibel-b6d27e60d524@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260219-galaxie-sensibel-b6d27e60d524@brauner>

On Thu, Feb 19, 2026 at 09:04:06AM +0100, Christian Brauner wrote:
> On Wed, Feb 18, 2026 at 09:51:10PM -0800, Christoph Hellwig wrote:
> > I'm not sure what replying to an 18 year old thread that's been paged
> > out of everyones memory is supposed to intend?
> 
> I'm so confused. This showed up top of the batch of mails from the
> mailing list for me locally yesterday.

Ok, I figured it out...

  David Timber (Feb 2026, Mozilla Thunderbird) — exfat: add fallocate support:
  In-Reply-To: <>
  References: <>

  Tom Spink (May 2008, git-send-email 1.5.4.3) — [RFC PATCH] Introduce filesystem type tracking:
  In-Reply-To: <>
  References: <>

  Dmitri Monakhov (Oct 2008, git-send-email 1.5.4.3) — [PATCH] kill suid bit only for regular files:
  In-Reply-To: <>
  References: <>

  NeilBrown (Feb 2025) — Re: [PATCH 1/6] Change inode_operations.mkdir...:
  References: <>, <CAH2r5mvXVc4=ZwvfwZtVaVM88+3cvUtjz-71af_Q+Jmbdst2_g@mail.gmail.com>

All these mails have a broken header and set In-Reply-To: to <>:

  In-Reply-To: <>

So all of these messages share a single bogus parent with the empty
message ID <> and then Neomutt groups them together which makes it look
like a really old thread got new replies...
