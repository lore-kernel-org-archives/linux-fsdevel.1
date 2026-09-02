Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899E3361979;
	Wed,  2 Sep 2026 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369224; cv=none; b=PtGDl9Ku3l5Z8G3duAUVhvZyNWWm9X8cg7orw2/knmMnRJ1fk+lY3hKk/f4O6+EXZMRkOAXo0WOGOs04+s7WU5tL4pPii/iDCUPNtjkJQ850x5kb4DbGd0njSlmPs2U7CJOdEqDQjFLZZE2JqcWMUAdTc6O0HO+dT/O4pJGjbYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369224; c=relaxed/simple;
	bh=XNQEDe85mM/uphxeT8S3SR/Yec7GZbdXU1+py517ups=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oj7Af22hjulWoSW753eXxzwMa9IAsck0ccrLLxzyZ1QXQLB2OMXskUakAsf7lyW+oF3j0cjI4U7PDYVs3e76sjaVxhPleuht7Yid0JBRrPYAzX8Nyh4PjRi1j9WtL6Qpj3Y2o95NSKZwMwRTWm02pgjESoam5lDhyV5hkoBypMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PsRDGgd7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PsRDGgd7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=tPYPDYewNeawBi07p/nAs1ibrnpGT5ATVl7N1IHg4KQ=; b=PsRDGgd7vGLOAFVuJrqFJWrV98
	0tjx9MzA56CZk0CQ9Iduswwhk73iSP37LRiKXrX7S4hmKECQ97qJLr9B7AKNwiXyOzirfkVc4dNLh
	Oqeb84I4URhLK3vKCocw86Ht1T+OAs+oIurk+ssjJZGWhVpYXfjoxxo+XHlxZmdxO6k+DgdtaRZ5r
	CtYnuS8AUH/AMwYUZ8g1ddjYJUxRTs1jsyG6mJFLmLc7LkuWViqqBzYS5/L+ZSKWD6Y5yjkZ+jM40
	iBrirKdew1l0TKEW2nf+ihFWZEXpwoPsxxax3wXKMReQFztuoEeQkpdeong/65tdMapiZWIN81Mie
	qOv61AKQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1oWr-0000000FPZl-3jei;
	Wed, 02 Sep 2026 17:13:41 +0000
Message-ID: <e0c0ab31-8f19-437b-b8c0-3ed6963e9064@infradead.org>
Date: Wed, 2 Sep 2026 10:13:41 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: locking: Fix bracket
To: Jan Kara <jack@suse.cz>, Manuel Ebner <manuelebnerli@mailbox.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260902143936.703665-4-manuelebnerli@mailbox.org>
 <ffoup27vuua4yo5weeyhgdjevtb4c2nkoz45lkk5kzipnnhzsn@wckefd3i2vv4>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ffoup27vuua4yo5weeyhgdjevtb4c2nkoz45lkk5kzipnnhzsn@wckefd3i2vv4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/2/26 7:58 AM, Jan Kara wrote:
> On Wed 02-09-26 16:39:38, Manuel Ebner wrote:
>> Remove needless '(' from code block.
>>
>> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> 
> Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> 
>> ---
>> Should I also replace ')(' with ') (' as it is in the second code block?
>> It would improve readability in my opinion.
> 
> Dunno, at least I'm used to the way which is written here :)

I agree - this looks typical to me.

> 
> 								Honza
> 
>> ---
>>  Documentation/filesystems/locking.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>> index 844d65eb4..1598cf555 100644
>> --- a/Documentation/filesystems/locking.rst
>> +++ b/Documentation/filesystems/locking.rst
>> @@ -27,7 +27,7 @@ prototypes::
>>  	int (*d_init)(struct dentry *);
>>  	void (*d_release)(struct dentry *);
>>  	void (*d_iput)(struct dentry *, struct inode *);
>> -	char *(*d_dname)((struct dentry *dentry, char *buffer, int buflen);
>> +	char *(*d_dname)(struct dentry *dentry, char *buffer, int buflen);
>>  	struct vfsmount *(*d_automount)(struct path *path);
>>  	int (*d_manage)(const struct path *, bool);
>>  	struct dentry *(*d_real)(struct dentry *, enum d_real_type type);
>> -- 
>> 2.54.0
>>

-- 
~Randy
