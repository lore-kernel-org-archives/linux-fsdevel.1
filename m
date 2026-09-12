Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CCE4BEE43;
	Sat, 12 Sep 2026 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789234557; cv=none; b=oY4EujTELBdYvjbD3cGVdy/FJt51t+9Yi5vZfYIsCDv0T49cih4PUWlNKxR0n8IA0Ki5WhozUxl2FwtzE3T4olM4yQZZSwgEUXOGFlBR5SbT28p1EuGx1KzaS39EmM5GHkIugiS/usKMN34v+sLE/ijqiwLnqvauhnXptUV5bi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789234557; c=relaxed/simple;
	bh=2ym46DYtEiXCcUt0q5Snjkv/IVipx/Y/0aVb/GzE2N8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CjMC7CcWGSajcDQizCHyFgZH7raRpGvm9jcn6hDHzdbfblNpqmWnBeblm80mQmld7uKgOWfuW0joj98Ym1l+zy8WAin6IZyd3hVg2UTBPIAfBLOBQOdaR44TFa/ARtrSsLlJpj1XcT86KUQVIfUzp4Pt/L4bofqyCpjpz71lwIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qVdsQMhf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qVdsQMhf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=SkHWeSKclNj15GV7KAPfWvuOJ9MQh29mBLhr/+HSj8Q=; b=qVdsQMhfQoh+HOVWoQCmMZ3kpR
	G0e0CrRtUTUuUYDCePSWAqwA/0IW9XulYz+aBuVBS6eVcxKN/hfsvWMgD624omXZ8rqV2RihIqALl
	sxNE9+fxDRLtVEzOF87R8QZJZVYwWWN9kUSb9IK2KwHYO2P/CQQ6B8BLvfaNl/TwSs76NLG1eBhZ2
	e0n861bUadhrd3GpVtUnfapY6ifDreIk8e123644wxKvqR27RWcvMEyvNMV2O/ca1L2FcpQ2A5dd/
	KAlrvvEvMGoSBvcv1HxmRr4O+MKxxiH5bcaHbeZ9ZR0jmqItdQYvhuEtfWWI5rUIKXPdGgsjUxmCc
	66A5Z4NQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5Rde-000000012qD-2dww;
	Sat, 12 Sep 2026 17:35:42 +0000
Message-ID: <01ae4e36-cc13-4420-a46b-69de5fd37fb5@infradead.org>
Date: Sat, 12 Sep 2026 10:35:41 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/vfs: Fix the struct file_system_type copy
To: Karl Mehltretter <kmehltretter@gmail.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260912073250.51074-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260912073250.51074-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/12/26 12:32 AM, Karl Mehltretter wrote:
> Commit dc651e25a6d2 ("fs: RCU-ify filesystems list") replaced the next
> pointer of struct file_system_type with an hlist_node, but the copy of
> the structure in vfs.rst still shows "struct file_system_type * next".
> Show the hlist_node.
> 
> Fixes: dc651e25a6d2 ("fs: RCU-ify filesystems list")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/filesystems/vfs.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index d3a93eec3945f83e057fbd6bc3ce519da03ea66f..56c68f4aefbac6f7be979f5ebc2a0aee886e13ae 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -117,7 +117,7 @@ members are defined:
>  		const struct fs_parameter_spec *parameters;
>  		void (*kill_sb) (struct super_block *);
>  		struct module *owner;
> -		struct file_system_type * next;
> +		struct hlist_node list;
>  		struct hlist_head fs_supers;
>  
>  		struct lock_class_key s_lock_key;

-- 
~Randy
