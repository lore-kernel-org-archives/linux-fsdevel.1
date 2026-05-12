Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB063299927
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778587968; cv=none; b=dxRkM1hiJycVBcRJX8nGLpupDA4UMogatjM4obppyJdOCSUBtDYqji9PXEuXhKbgHtYA/P1HBYXMaOZTQFTq58PqOHNr9DPNiFA6nnEZ6fJ6yMxW1J8hnmhTtUIG+NYIw3OMaN8JHUu7ICBQGwB7vwaW74sSN6cAUnHgkDqL1Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778587968; c=relaxed/simple;
	bh=/9dnAltSZovT/E00djwfS2l+dkMsZbRXWj3kVzkhyQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEgw3wT8YnCc1XrXKMu3Q+uAPxJ4cXIRPxJt7v4pNc5FXn6hJdiMJuKSgcs7RnuEyj9tOqYCLVyHrUBtUGPVyfj0escyjolqvgGAujkKivOQ+CGtjji5C0tvqvlTDVfJFeMhJxGtc3XmubFjZ4m5UK27whHXId3wY48kz4AbDWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q72LQmLm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q72LQmLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B635C2BCF5;
	Tue, 12 May 2026 12:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778587968;
	bh=/9dnAltSZovT/E00djwfS2l+dkMsZbRXWj3kVzkhyQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q72LQmLmkACmQ1OdbwME8lOd+3kGDIout/eK1R8Jsju8ddN1QO52xuVmES/T11w//
	 +GVARS2lTBNENH8KoZFQI679lQqiQoWkWX+BNSBcllSx+IHhnOfBz7bdeeQuGGcV1e
	 /FZwQuBVZiJehm3X29MUQTJ893jppiuwt/l8tvdXlRk1pTo7wb5CeZIUBBXZiSBjQ2
	 Dr9Lc0Rh311PhKbdmfOLs+eCqy1TW8ulkQyhxEqAO7vJvCyg/kGtD/st3rUp/KGQ4J
	 TsGSRT7Aer08T8tGT0vstC9AQCb4CJQUE/nNq29uo8G+Gf3b17+aC/v+MH2AKPOYBb
	 lB++FcYbuSUGg==
Date: Tue, 12 May 2026 14:12:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: djwong@kernel.org, Namjae Jeon <linkinjeon@kernel.org>, 
	willy@infradead.org, xiang@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RESEND] iomap: remove over-strict inline data boundary
 check
Message-ID: <20260512-marmeladen-abgraben-55a17189978b@brauner>
References: <20260511141151.6021-1-linkinjeon@kernel.org>
 <20260511-banden-sirenen-86654d8201a6@brauner>
 <20260512060736.GA28955@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512060736.GA28955@lst.de>

On Tue, May 12, 2026 at 08:07:36AM +0200, Christoph Hellwig wrote:
> On Mon, May 11, 2026 at 04:57:26PM +0200, Christian Brauner wrote:
> > Applied to the vfs-7.2.iomap branch of the vfs/vfs.git tree.
> > Patches in the vfs-7.2.iomap branch should appear in linux-next soon.
> 
> Shouldn't this go into 7.1 as it fixes a user triggered BUG_ON with
> ntfs?

I was on the fence but there's no Fixes: tag. I usually mark patches at
least with: Cc: stable@kernel.org # mainline only or something.
