Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F4426E70E
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 06:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172248; cv=none; b=YJ6ALY9pc0r7SGTz7a1i9TM4ksTIJEnFxG6ox1+N4N7mHpe0A6sgsz+zJAoqw564XchRZ5K29HqyjB2yQPNrHuyqoCYqwIiVbEM+qqcOXEaXiOzxhHeUXFYUSM8shun8e4IWw31POtQWvyyqRAxOPhRsJrbcuFRIoIYqMlMyOpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172248; c=relaxed/simple;
	bh=pvQYeZ/Smgee1WmxcXJeiy3ww2OHUpJ31k3PKgkNMsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8A/8zMbiyYVW5zUrNg9lIVLjCq7Vn7TEQS5/kEcMXnJfSBTP4K6F+UrrUDaON0GpsbkAPHMqZcWlrbQ243Hzq7cltq796QWDmDj58msgudBCJ6qTjAIZORMd8DNyNpBFnslq1He6zjMwF9D1iG8z/1cN1VmdsrwKt3xL2v8V8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PxKgRCKO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PxKgRCKO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pvQYeZ/Smgee1WmxcXJeiy3ww2OHUpJ31k3PKgkNMsg=; b=PxKgRCKOWAK1vi4co4Hs+2g8AE
	008AvuAjfLlpHWbkibT/7HQZmXFBVnfsqBgr00TX5YbdX+nubi4sfe/BQr+mYuvyDHdOotw/TaR2+
	3ulcIeLwu65cuIJWGhUmmFcILAXTshJmXDfi9uYrMd8IlyyRcf9xHB1l1auKQJPXCFtj74VMoPVQ4
	oyDwUbuWTDCt5xzqYFX9kkOMeFgQnW86+vWM5y2VE/so8NHMsgN6C4TIH0xjs46XANg1VUnkZwf6u
	va+EHKJ65X8Co4jEB3L7pfHCCFmOdNZxN672Q+H0YAe4/UBa4zQEjFdX6lzGoF4tBrgAmS4KTKiyG
	tG+eGFgw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPDyY-00000000La1-0cMQ;
	Tue, 19 May 2026 06:30:46 +0000
Date: Mon, 18 May 2026 23:30:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yi Xie <xieyi@kylinos.cn>
Cc: linux-fsdevel@vger.kernel.org, Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] exportfs: fix error handling in expfs.c
Message-ID: <agwDlgy8EOC9sJEJ@infradead.org>
References: <20260519010140.37251-1-xieyi@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519010140.37251-1-xieyi@kylinos.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 19, 2026 at 09:01:40AM +0800, Yi Xie wrote:
> dentry_open() and fh_to_parent() were calling PTR_ERR() before
> checking IS_ERR().

Calling PTR_ERR before IS_ERR is perfectly fine as long as the result
in only used when IS_ERR is true.

> Drop the redundant sched.h include too, cred.h
> already pulls it in.

And this has nothing to do with the rest.

