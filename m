Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35CE194C96;
	Fri, 24 Apr 2026 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777065172; cv=none; b=TG3DcaMiM5lLgponEzmmznMwUvexdFDowhCXXGT8+l0ZMWMTlj4wlwxOF/s/FXINCE67540NS9In2clNRiEhMdJxbHIVvSY1R/8NkIJS0yJQuY4bsX5Nw8P0Q4Kxa3Q2q013IEKj1Kf9e/tC4THDYTbUN7ohJXp0eEXCrDGYcS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777065172; c=relaxed/simple;
	bh=NyikAh4tm5Tv7STEBSnCqg4DtovJNqyU4Fb7MI1sEhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XH2KY9XYRsAm74SmxrkN/r3GZGRiPxnS/5TUx8RyJLf1D1L55JtBsfb2TPfflkisW1KDOKhNFH5WBPIe6SC84pj6eqSWOLym0+aTDlm9dRpVyFy1dWSzJE3P/PbCEBHMIyJXHa4g8d440zY/N/oWqL/1RG//vQgIOSW+IDPO9Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TGDN99yu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TGDN99yu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=8PzjeiGcbLPGB7W2FflvnqZlR4Sy4gQvM3bCbeF+Jhg=; b=TGDN99yuCtcPOl0JlU3sSfwcH5
	fx8xtU2wwXHAkIvlXe4EEM0axMcUf7gpxYh7jqgLEG341rxCWjDY1gCmvqVoO6NZPdGbBEkLbQepf
	obybtZz1s5IcBvQg1nvKOqKnNxkuZSjeJEGbQpTA+iviw5hQXYNoBK7ix1eGG4Xnhg+pF8OjTN6pf
	x1cMpw0ZnsPCUCuw0HbtuxHigv0q+eHHa4kbrErhANRhf2tEWz8PRyZknBzctEOFSKSe6IFhZkIpC
	6mTmliK8Xf5UV66+9v+HshTf+xQQ2Q7e8bDNq7e922ROggjX1EGMveLObwEWH/lrbpY72rLRLrpAU
	QiPqlZaw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGNpM-0000000DlGf-1h8t;
	Fri, 24 Apr 2026 21:12:44 +0000
Message-ID: <df3b6729-ed3b-42e3-9a8a-f77ebf827dd7@infradead.org>
Date: Fri, 24 Apr 2026 14:12:43 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 v2] Documentation: proc: fix section numbering in table
 of contents
To: Baolin Liu <liubaolin12138@163.com>, corbet@lwn.net,
 skhan@linuxfoundation.org, cyphar@cyphar.com, vbabka@kernel.org,
 surenb@google.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
References: <20260424090654.19229-1-liubaolin12138@163.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260424090654.19229-1-liubaolin12138@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/24/26 2:06 AM, Baolin Liu wrote:
> From: Baolin Liu <liubaolin@kylinos.cn>
> 
> Commit e24ccaaf7ec4 ("block: remove last remaining traces of IDE
> documentation") removed the IDE section but left its table of
> contents entry behind.
> Fix the stale entry and renumber the following sections.
> 
> Fixes: e24ccaaf7ec4 ("block: remove last remaining traces of IDE documentation")
> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>

LGTM.
Acked-by: Randy Dunlap <rdunlap@infradead.org>

I note that the html-generated TOC is already correct;
e.g., https://docs.kernel.org/filesystems/proc.html#networking-info-in-proc-net
is already section 1.3.

AFAICT, this TOC is for users/readers who use an editor or pager
to read this file, but the patch is useful in that setting.

> ---
>  Documentation/filesystems/proc.rst | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 7ce02573a3d9..70db35987ee1 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -23,13 +23,13 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
>    1	Collecting System Information
>    1.1	Process-Specific Subdirectories
>    1.2	Kernel data
> -  1.3	IDE devices in /proc/ide
> -  1.4	Networking info in /proc/net
> -  1.5	SCSI info
> -  1.6	Parallel port info in /proc/parport
> -  1.7	TTY info in /proc/tty
> -  1.8	Miscellaneous kernel statistics in /proc/stat
> -  1.9	Ext4 file system parameters
> +  1.3	Networking info in /proc/net
> +  1.4	SCSI info
> +  1.5	Parallel port info in /proc/parport
> +  1.6	TTY info in /proc/tty
> +  1.7	Miscellaneous kernel statistics in /proc/stat
> +  1.8	Ext4 file system parameters
> +  1.9	/proc/consoles - Shows registered system consoles
>  
>    2	Modifying System Parameters
>  

-- 
~Randy
