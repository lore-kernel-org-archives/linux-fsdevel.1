Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811168;
	b=z0faBIrRXmXP32IJrdeLl62T+o8KOHi74u4vTzX7M9MYDxvzhuOAZ0eEONy58tB8mxdN
	 m052WQjFJY+TVhPc+i81iUo82CkLlD0oNgKGHgMaQ2oSOmVP6zOrHGDuAupT6dgNIkiWK
	 HLVoda1GJp39EJpBltO3TuH+Yt9F66zuvMKFbwn/EPO0wavz8joRTpWN34tiWzInOxlYf
	 UD0U08XHYmbw1hXlcFAtwb+AhMc7k2eL5DY619BFFpvfgLEMD4GFMbWpGjC2efqCWBCcN
	 Pg49oRx7UYx8XtZWx9nyY3otZo2EIZku47PDP02raH8khaJcehB6bk4yf+QZk+On5dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811168;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=8+iR4niHczic0KzJmA8oF+7h1DwHaTXrdYECxI6T5P4=;
	b=0v0PGu1aqvLBvp3g2LI6fDuHxEd1TYfX+nqWGcaujfoS/SsZzGsyyE+CDIyi9JEG4+f7
	 FEDXbflJtH+01xTVplNmvffB09s6Xywr4ActETgK7KNr3EQJ/jRykv+AlAI/+J3Oq7qJC
	 T/e+P4V1H6iBLhoQC3VVL8MmeQKeJqqHQgRbfO3gh+qDpCVQo9wjuvANw8GXFWRslUxBv
	 1aHNomr0SbVrLmiDYxcGQNxFIbLItgeNBGr+jiY34FptT4BAHw93r7K47kXPniCw7eRdk
	 J/W4vyYR7A13hh67mtqDHQCiAm09Gp0O3+29qPQipBat+YfUxxQJyN4DT9/UQ61IP3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MwblwEnl;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A72A606A323;
	Mon, 16 Nov 2026 06:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A72A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MwblwEnl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=8+iR4niHczic0KzJmA8oF+7h1DwHaTXrdYECxI6T5P4=; b=MwblwEnliTeyRsI0YjRVZgrHXR
	yyQ7pmXkqc87VxwqOih58LWjUOrBxr2VQk190xsc7NakZFA8OOC4O+i4wwihOKjSCYu7IDRVctoMd
	J2gQUXEasYYAfa81tHtXXCIa8U5iTXPOMTYv+Uxpvcv8+QDTCowl9PS+voUUTZLbU5S2oJFJj4fAR
	Esdaq4ai2ndU6SsXRoTGtVUWrBmQux+1TZ9omxmhDNKuJIQGgX4gThBrMw6g/yLu9E27gkuFmLrZ7
	TmWJmG2oSry9UfrJFGoM4XjZ7tVyg2EoV4P/hVkCl5kW0BGubx5srlpMquD4f0Bwc3UK8qjpldVt7
	jEOaKbmw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSqNC-00000001K0W-15xT;
	Mon, 16 Nov 2026 06:39:26 +0000
Message-ID: <2571c5d4-f7c9-43af-b6ef-12f7414d4709@infradead.org>
Date: Sun, 15 Nov 2026 22:39:24 -0800
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: porting.rst: use literal string to avoid warning
To: Bagas Sanjaya <bagasdotme@gmail.com>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-doc@vger.kernel.org
References: <20260924183915.400588-1-rdunlap@infradead.org>
 <hyk4puvpheleitf4kt74aamqex2ytuxpda2iki5bgzoteldf23@pccvy6sdmerx>
 <avpzSippbZRkaki9@archie.me>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <avpzSippbZRkaki9@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bagas,

On 11/15/26 7:06 PM, Bagas Sanjaya wrote:
> On Fri, Sep 25, 2026 at 11:32:43AM +0200, Jan Kara wrote:
>> On Thu 24-09-26 11:39:15, Randy Dunlap wrote:
>>> Avoid the docutils warning:
>>>
>>> Documentation/filesystems/porting.rst:1417: WARNING: Inline emphasis start-string without end-string. [docutils]
>>>
>>> by quoting the const pointer in literal quotation marks.
>>> (Adding a space between the '*' and the '.' also works but it looks odd.)
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202609231806.ILZP6Fy0-lkp@intel.com/
>>> Fixes: 025756ee7b47 ("fs: port mnt_idmap() and file_mnt_idmap() to const mnt_idmap")
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>
>> Thanks! Looks good. Feel free to add:
>>
>> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> I still see the warning on current docs-next, though. Has the patch not
> been applied yet?

This patch went thru the filesystem tree and was merged into mainline
today (Sunday) - Linux v7.4-rc3.

-- 
~Randy

