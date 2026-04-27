Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CAB3DB644;
	Mon, 27 Apr 2026 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309238; cv=none; b=SwL1Jjx8fT+Tp/xf7WMNHvBItmCMq5vMQ2qev1JE8j+A1c8uESxDY3dDAzuccyJrAAeitU8CKOqZYnGGqU4YnAnuKW+d8qaUuML6cqkyIexFBqHeCsRJAqtUbsYxx7JIHGV0RDBE01lmdZ0qsSLa5qLyHWvgmOqQBpJfhGpWFBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309238; c=relaxed/simple;
	bh=YXXGHWsPBPRPEzaPrYolW+Wu4uuwei/TTKFDRMYj/Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOvHM5uEmQNMzUhGhaqvoXzctsl2NVP68WZvALcVicsoB5EEeRYcMbtuvgioaohN6PEq3Cf7U1ZnYYBNYJ/e2ToxPrRN2lHvL+NJWaZI1I1ZJZrYp8eY+aC+9NczZgdBCM3ErXptSuQmJlekICAWrfix6Gp1+OD5lpFS9jpZQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mabDjsyX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mabDjsyX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=bADU0bpxGz43Tyth14UHuz1PQjWoIRpdpcDPh7Eb24A=; b=mabDjsyX3vcRhggS6ICSoTfB6j
	U813JKtVm65NQKjnQhPJioE4NoR2Dak48WiUCnopd+7KrMrhej9tfaqtDMKEiK2xx0DfWd9UdIqwp
	HmzCcRTqZhKxIA1z8QpM/BJhb8jQc+j34J1lzphhJteiq6cnkl/5PF4964O+PJD7PwA5Az3F2d8VP
	ABXnEbJ3xhAnQzedbh3cgTJHWAj/oH4Uy0aa0DSFmSeDppS55xOUbDelijWJtUFILhBYvgq27euzk
	bEvPEUqS7tgua1dQV/SDFnJyje3s2SjCfHympzkSoCdOybMKugZekMK52ZEBSlIVuhw9UpCeInZ4X
	5RHY2U/A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHPJw-0000000HOuS-12iK;
	Mon, 27 Apr 2026 17:00:32 +0000
Message-ID: <da60b774-abde-4597-85f1-1355ab2a3c3a@infradead.org>
Date: Mon, 27 Apr 2026 10:00:30 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 v2] Documentation: proc: fix section numbering in table
 of contents
To: Jonathan Corbet <corbet@lwn.net>, Baolin Liu <liubaolin12138@163.com>,
 skhan@linuxfoundation.org, cyphar@cyphar.com, vbabka@kernel.org,
 surenb@google.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
References: <20260424090654.19229-1-liubaolin12138@163.com>
 <df3b6729-ed3b-42e3-9a8a-f77ebf827dd7@infradead.org>
 <87wlxspw1j.fsf@trenco.lwn.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87wlxspw1j.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/27/26 2:55 AM, Jonathan Corbet wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> On 4/24/26 2:06 AM, Baolin Liu wrote:
>>> From: Baolin Liu <liubaolin@kylinos.cn>
>>>
>>> Commit e24ccaaf7ec4 ("block: remove last remaining traces of IDE
>>> documentation") removed the IDE section but left its table of
>>> contents entry behind.
>>> Fix the stale entry and renumber the following sections.
>>>
>>> Fixes: e24ccaaf7ec4 ("block: remove last remaining traces of IDE documentation")
>>> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
>>
>> LGTM.
>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>>
>> I note that the html-generated TOC is already correct;
>> e.g., https://docs.kernel.org/filesystems/proc.html#networking-info-in-proc-net
>> is already section 1.3.
> 
> There are advantages to having a computer do a job like that :)
> 
> I do really question the value of these manually maintained TOCs; they
> are always going to be out of date.  But ...
> 
>> AFAICT, this TOC is for users/readers who use an editor or pager
>> to read this file, but the patch is useful in that setting.
> 
> Others seem to disagree, so we keep them.
> 
> I've applied the patch, thanks.

Yes, others do disagree, but my comment was not meant to be an endorsement
for keeping it there. I'm fine without it.

-- 
~Randy

