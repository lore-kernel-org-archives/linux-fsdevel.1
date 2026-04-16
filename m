Received: from mx.fmap.me (fmap.me [51.75.121.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F239215FA81
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.75.121.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776343773; cv=none; b=EVSzF0+zDqkEzEpyCnTovQe2BJZmJZwpSWXXqQOVoe1eGksgYMj3A39CyFT2vB3p+ks2+4KARfSAXZsvDjhUMdITn7VWAEgR53+JZmFik9y3fybb3jtsxSRxQf/LNEa2syDuE9LD27Ws9ygHhh93L+b7XvSLQxvHoRUbiRn7zis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776343773; c=relaxed/simple;
	bh=dRKLOVDG+PQyoeFzLFR2cw0HM9BPrj6eMGSOG/ptbhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxGTzCCv7NTUtqosMbRLElxLghcjR5EOXHhRpo3jWerCI6drkHk6QWiSIX76akCXo85ds7K/wuI6xNTWCiAoX52S9Jt5wa9oTSmDeDiRoWVOkiMIYTrNoQTdYjZg7q0o1QvykdCQluD0sKaiSqgfgl9N7uydDe9MJ/hmqFdvEwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fmap.me; spf=pass smtp.mailfrom=fmap.me; dkim=pass (1024-bit key) header.d=fmap.me header.i=@fmap.me header.b=G1C0y/8M; arc=none smtp.client-ip=51.75.121.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fmap.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fmap.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fmap.me header.i=@fmap.me header.b="G1C0y/8M"
Message-ID: <ca73a724-2e6c-4474-8301-32e509f553bf@fmap.me>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fmap.me; s=mail;
	t=1776343770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nDRa5CfUbhqNNkRrJRkBwEijvm1dQG+Se0DmjI5DvHw=;
	b=G1C0y/8MVky+yHo8qUSlLtizv+3LTEBROx6KHcit4DTtzxXl0JQX39I5G+Uxk26+WdHTiX
	Sl9e6emH3jgGUM3epLF3zG9+RY0tEyAg4xcziPNpZXtWSu3lL6k35OueAfxppwqKCfUuDb
	TDR0G764/94ORThIQbcR42cNdVr5hwk=
Date: Thu, 16 Apr 2026 19:49:24 +0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [fuse-devel] Debugging a stale kernel cache during file growth
To: Miklos Szeredi <miklos@szeredi.hu>, Matthew Wilcox <willy@infradead.org>
Cc: fuse-devel@lists.sourceforge.net,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, fuse-devel@lists.linux.dev,
 linux-mm <linux-mm@kvack.org>
References: <898a4e10-6193-4671-b3b1-7c7bc562a671@fmap.me>
 <CAOQ4uxjoS-PvnZ2poh0bx0C6ocTYwuEpfV0q5md15SjS620OMg@mail.gmail.com>
 <CAJfpegvxF7F+XKFKokSH4eOgCA0V2RNm6B54MS9nr9wG=U66OA@mail.gmail.com>
 <59ab54f6-680e-456e-91f4-0a26889844ef@fmap.me>
Content-Language: en-US
From: Nikolay Amiantov <ab@fmap.me>
In-Reply-To: <59ab54f6-680e-456e-91f4-0a26889844ef@fmap.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/16/26 19:41, Nikolay Amiantov via fuse-devel wrote:
> Finally, if I understand correctly, this also leaves a (much smaller) 
> theoretical race condition in `filemap_read` between checking uptodate 
> and getting the current inode size.
Correction: "would have resulted" in a race condition if we would be 
retrying to get a fresh folio instead of returning an EIO; I have 
assumed that's the case when I tried the patch.
