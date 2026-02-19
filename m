Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4509D1C84A0;
	Thu, 19 Feb 2026 08:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771488252; cv=none; b=rIF55jSgW7Sy04ggixUdF5KP6quI+5txn3dPm6MyjJds4b8K4+nTrSsR6R1asfoFfYr6AdZJZr7jDQt0yPuIHFNj5TWvS9XjP78IRVV0HTdIxQDUyeRTvSK78BOX57tdP+oNyj2IzSio+RRuhbeK1EPR/pa7JI7rxCOBnmrb5KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771488252; c=relaxed/simple;
	bh=NVUYtecCF9wa3MX9UqJyTg7zs3yFZ9hMZXbz8g0TbvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cU1JU7NJaU7rwSS7JV15GVC0KV0gztwM28bk5shRDUWdiYTzfRDY9iBzjoV7ptuNcaSkovNuwojXnDOgnMmeI1vWtipVmHA3ZgkPgwguXYi3hVIZTZpYn9jWM/ZTSpYwyigO9zfijtCrQYGqkPZsvH7CZ4ec/JaXzCylhQniuVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL2sPzez; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL2sPzez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B7FC4CEF7;
	Thu, 19 Feb 2026 08:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771488251;
	bh=NVUYtecCF9wa3MX9UqJyTg7zs3yFZ9hMZXbz8g0TbvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JL2sPzezBV9TvE+WeD1Va1G8PzSLyf3eJTEDj2N2K8xN9h7P6vp6hswsXedNo/Uht
	 RpjhNrbEiwCK+Eq3886Qt8onTZAJcEK/TGnFLTsV92v9417/RQjW8Js8fIjOKVr7t6
	 CARAFG24Fr3rKJimUmK4JlXZFBAqjrV6VLAD0a5GZbEvhsjOT4WzXRqGMr1fL1RW1A
	 1gQoXUsoXWii1TgQFqp1JhjzHYLpa+H4jaed/8jKm327O49E3uSpcAj3/XsvT0I7z/
	 zHkKYgbMgfp8LCjvvOGjQmZeTFpJ9v8aNB/gTwEU/zLFNN1kAIeK7YNI2bg2zM83Mt
	 8Fm0PMHuKpyiQ==
Date: Thu, 19 Feb 2026 09:04:06 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Tom Spink <tspink@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] Introduce filesystem type tracking
Message-ID: <20260219-galaxie-sensibel-b6d27e60d524@brauner>
References: <1211196126-7442-1-git-send-email-tspink@gmail.com>
 <7b9198260805200606u6ebc2681o8af7a8eebc1cb96@mail.gmail.com>
 <20080520134306.GA28946@ZenIV.linux.org.uk>
 <20080520135732.GA30349@infradead.org>
 <20260218-goldrausch-hochmoderne-2b96018fbe5b@brauner>
 <aZakzr_QAY6a-dlB@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZakzr_QAY6a-dlB@infradead.org>

On Wed, Feb 18, 2026 at 09:51:10PM -0800, Christoph Hellwig wrote:
> I'm not sure what replying to an 18 year old thread that's been paged
> out of everyones memory is supposed to intend?

I'm so confused. This showed up top of the batch of mails from the
mailing list for me locally yesterday.
