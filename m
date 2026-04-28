Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890161D5174;
	Tue, 28 Apr 2026 01:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777338784; cv=none; b=EDai2ht7y1hWP7HHl6KS+IyUokQhlN6ZfqqbjfTy67qqlgibtkITfvm4jQXYLPA+OyV5LeL6UzTpAlA8vfN0JeWxTP8ei6z8QmNQHFbBLwyuDVE6l9O3R+PAa/+ScV0oIZWszOOzV71Fi90F8l/jIQvOBWQPi1ckKG4482lBZMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777338784; c=relaxed/simple;
	bh=PU5bsYLUe+TiVpktpinVPwfRPsPVWG9tY+c3tLjwhNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPdC4oxbtwBHhla310jtrMEHuTCUULrrlb6boRH6LHumWqjprQc6OaY2iJ8nZyCzxqTiihDzcajnkIgcPSdrFZk8n0Ytkb7JtfnM2Fu53UfoD8FrrbjC//wMyXktdPfNnljyDupbZYeiM1ND+P6KwrpeIR5rg9decC17bmFmNuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UGWG3Oc3; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UGWG3Oc3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777338778; bh=TNukEp4Dwl+Oqc1T43hxrWXMq55wH2a1IStVIx5h5BU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UGWG3Oc30SsO1zquk3Oaj5qOx9LwKsuRD+FfbxQ64Q3lnYQJQb7C30I5DnMyYWcfM
	 2PCBmRcoWBL6rbHKUnlbrwXHkIePwJm2QTppzXfkH09ZDcI7pT7QWgWDa5l1wsuVAM
	 4NOZkGnxNXKHpl1xAO7aUfZ2soQtTuSwUAmn8k3o=
Received: from [10.46.141.45] ([36.112.3.68])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 3380C219; Tue, 28 Apr 2026 09:12:56 +0800
X-QQ-mid: xmsmtpt1777338776tlo703va3
Message-ID: <tencent_6B7B248CE4DD2C5B4471193F7B295ACC1F0A@qq.com>
X-QQ-XMAILINFO: OeGSc/E1+fkZieFR4/4fnYbmy1HnY6cKD5MsG73FjmptXN344R/7b9ihhpBgX8
	 BdQWw6ukUuKmJadJm/42i5R4V2iVWPS6PgwZHXXgo2/h7iZqEk/Px9KFotn8NjeqkmfAmT8MNUCL
	 RB5lIojFgQ4nQ/GbKhdc3HtThIE4uERTcD3uWXuiDugy65MAVNaCKPELqF2onG9kJbwZ4yFhB6xI
	 bN261YjvNuq85fnz0u+YnkOb0MmHXBpes8GlkTJr7CWYq+HnE7PVrNl7TSW6qWC5nu6nxB5pGhJv
	 cAq+fv5GaojZ3ANi/SX0n0h8bNKaf2gXOykjwbsF5JWTY8GxlPhrKobMOqUUhWJXi3YEmuM/tVRJ
	 3zkQOqt59wiJYLTpzZADq4sgOGykHichHbSaWtt/Qwm2GJv4poDvmAkq2vzzfhg03mbqt1k0cxZw
	 ezgbLXURMVBRqVS7dscMYNZANHdkhcfpiL38KWdxL7gAAx9cFCDloSVGoUblGgGyUv2pCAtSTk36
	 CS5nn+PJSYXQaktGsyfdCZHbWYEso/vx9vkP1xLiSWpclR1+gaG/XwVH6RuzXnZGjWiXHsSzkEh/
	 DXLf7vLPpbXGQpY/KvgXBZfTc7O5O+efeWaYzQxqj57a1SDmoIpfJRggYrXIdaTp5iJKgBH9fiqy
	 RtpdD7lUfDl6mso5e7+0eeF36v3XQBFOnWMy7Ar23pqu7geWIUr7wFTGIOoItR5VhNCbZNkt+Ut0
	 3HkMNVCBqISTbUOLh5firDmxNyw5kTPLVrjpTmecQ/SjP39o3XH0TwMFZpAYThdfTFUd/uiQe+ep
	 KXrzliejf3ZUpf07vKLphlKfZLYs0VPSo1s6/09HT5mQ9saEvE7tX8J5etIlxJj2nfPl+cOROD/H
	 FH5MF5ZRnTSTCjrRSg7IfgCS5CasIRpus3AhgZrfADNPceZnN+z+jOHbRbxd14GbaNDUBdWume5A
	 NGrzhI4NmEOQbf4Mez+wpTu+naWaiNqZ+8VqKx+i/lHt+uAGqqJZgyLt5zdghTtuW+dBijy5Aoiz
	 K8mCE/6Qq1GtzU48nDkcseidwGkYKwpB3MnDV/yVH3/MLDkL4scfH1CTljvaBVb5yLRWRQxvExu0
	 qyqPj0DMMi7ZEg7R8=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-OQ-MSGID: <0d3230ce-1609-44b8-80c4-2e325e9817e8@qq.com>
Date: Tue, 28 Apr 2026 09:12:56 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/filemap: count only the faulting address as a
 mmap hit
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>,
 Haoran Zhu <zhr1502@sjtu.edu.cn>
References: <20260427165751.746502-1-fujunjie1@qq.com>
 <tencent_949F3B157FE71D3C7247AE6FAE2C5AB82809@qq.com>
 <ae-tkz6qe1zFmXVj@casper.infradead.org>
From: Fujunjie <fujunjie1@qq.com>
In-Reply-To: <ae-tkz6qe1zFmXVj@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On Tue, Apr 28, 2026 at 02:40, Matthew Wilcox wrote:
> On Mon, Apr 27, 2026 at 04:57:50PM +0000, fujunjie wrote:
>> -		/*
>> -		 * If there are too many folios that are recently evicted
>> -		 * in a file, they will probably continue to be evicted.
>> -		 * In such situation, read-ahead is only a waste of IO.
>> -		 * Don't decrease mmap_miss in this scenario to make sure
>> -		 * we can stop read-ahead.
>> -		 */
> 
> I'm sad to lose this comment.  Why not move it to ...
> 
>> +		ret |= map_ret;
> 
> here?
> 
>> +		if ((map_ret & VM_FAULT_NOPAGE) &&
>> +		    !folio_test_workingset(folio)) {
>> +			unsigned short mmap_miss;
>> +
>> +			mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
>> +			if (mmap_miss)
>> +				WRITE_ONCE(file->f_ra.mmap_miss,
>> +					   mmap_miss - 1);
>> +		}

Yes, that makes sense. I'll move the comment there in the next version.

Best regards,
fujunjie

