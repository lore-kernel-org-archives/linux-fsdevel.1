Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F34282F29;
	Fri,  3 Apr 2026 02:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775184210; cv=none; b=S+2CCkEmY2g38TiJ0te+m1kpG/t3FjFiiAFyMuB0wwRVe/x4uMM9DZwdojVDaOb7q6ktNUem6BEXXh6aC1n2ki9keWLZMxwt8m3TFKRgmlIXSgfOjROKQ7cduFBkpCM4zUWXJggNm21fXzt4yUCl1/PWwTTtLFG2j23Dtnbty2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775184210; c=relaxed/simple;
	bh=G+xz/Bj5Agf213QJOAj08lJM0LNpZC82a6+fI+DkKWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ooIfQvjNVbiRfKMK2VdRLKyZ0kddFhCSuPVJGlMv0DMnBL1TdlipjHrVeculUvvQ2njuU/RaGTXXM1TWMmMth2Nuqpp2BkOGbGQztvzxzCiR3oKdd/E4JEIukFKf3NEf+fgokIBWCMQWGtxEFwHFhJMP+1kGZynUlG2MePiu2Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=myJEJH0o; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="myJEJH0o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=yJ01XM7J4FxldIGw18m4X4AqJhibQHzCRL9ilwhkJfE=;
	b=myJEJH0olBAkplOaTaAozhPhGWTHFhyWddugVrIN6XzGssVAzuysE80zBrxkZW
	VxezcJ808waXN3bVbkCbxc5dobHGBkqE2ucnzwyzrHMQZ7CWLp8j9OPgTiQ16V/Y
	xhqfPBPt2RMzy4fm9eOMh6PCLSgO0YzZkYdCrWFoc751g=
Received: from [10.42.0.216] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAXLvU5Kc9pxNbtCw--.828S2;
	Fri, 03 Apr 2026 10:43:06 +0800 (CST)
Message-ID: <6839cce0-4d2e-4b14-9dfc-990185fb9149@163.com>
Date: Fri, 3 Apr 2026 10:43:05 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] exfat: use exfat_fat_walk helper to simplify fat
 entry walking
To: Sungjong Seo <sj1557.seo@samsung.com>,
 'Namjae Jeon' <linkinjeon@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 'Chi Zhiling' <chizhiling@kylinos.cn>, cpgs@samsung.com
References: <20260401071138.114836-1-chizhiling@163.com>
 <CGME20260401071219epcas1p382c16d770872794223bf7d67c79f401a@epcas1p3.samsung.com>
 <20260401071138.114836-4-chizhiling@163.com>
 <015c01dcc2ac$1ffd7520$5ff85f60$@samsung.com>
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <015c01dcc2ac$1ffd7520$5ff85f60$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXLvU5Kc9pxNbtCw--.828S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFWkKFyxJw1Dury7uw1kuFg_yoW8WF13pr
	s3Gay3trW8A3yDCr4jqFs5Za4avws5GF4kJrW7Gw18Jr90vrnYkFyDK34xW39rC3y09a1F
	qryYgF15WFsruFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U20PhUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9xqmRGnPKTpqvwAA3v

On 4/2/26 10:22 PM, Sungjong Seo wrote:
> Hi, Chi Zhiling,
>> Replace the custom exfat_walk_fat_chain() function and open-coded FAT
>> chain walking logic with the exfat_fat_walk() helper across
>> exfat_find_location, __exfat_get_dentry_set, and exfat_map_cluster.
>>
>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>> ---
>>   fs/exfat/dir.c   | 39 +++------------------------------------
>>   fs/exfat/inode.c | 11 ++---------
>>   2 files changed, 5 insertions(+), 45 deletions(-)
>>
>> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
>> 7619410d668e..cfc6f16a5fb2 100644
>> --- a/fs/exfat/dir.c
>> +++ b/fs/exfat/dir.c
>> @@ -562,38 +562,6 @@ int exfat_put_dentry_set(struct
>> exfat_entry_set_cache *es, int sync)
>>   	return err;
>>   }
>>
>> -static int exfat_walk_fat_chain(struct super_block *sb,
>> -		struct exfat_chain *p_dir, unsigned int byte_offset,
>> -		unsigned int *clu)
>> -{
>> -	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>> -	unsigned int clu_offset;
>> -	unsigned int cur_clu;
>> -
>> -	clu_offset = EXFAT_B_TO_CLU(byte_offset, sbi);
>> -	cur_clu = p_dir->dir;
>> -
>> -	if (p_dir->flags == ALLOC_NO_FAT_CHAIN) {
>> -		cur_clu += clu_offset;
>> -	} else {
>> -		while (clu_offset > 0) {
>> -			if (exfat_get_next_cluster(sb, &cur_clu))
>> -				return -EIO;
>> -			if (cur_clu == EXFAT_EOF_CLUSTER) {
> 
> The intentional exfat_fs_error() call for chain damage conditions is lost.
> Instead of removing the error handling for this condition, it had better be
> moved to exfat_find_location().

Wow, you’re right, I did miss that.
and your suggestion is great.

Thanks,


