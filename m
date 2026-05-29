Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EE93624C9
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780095252; cv=none; b=a+ZqukToGupLEkQ8Nz1LQRbAI+38w0grf1Jcsb95aEcFWuFAEDadPF4ZTufYb4ml8GZ6znpq+6uXJiSUHm5P2MNf/aSIhDgaR8rulu33Qug8jLyaUhp4oPkanvB9rd7kUpZ8ZjgclCCfHT5ZfTJ8mxfo6DqKCisvU+sarOX2qak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780095252; c=relaxed/simple;
	bh=VqUDarAfMpodcO2RjjjUxeiD3RKyxcs+yKqS/ZiCUh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvuoFTW5A7eBgCk003KrRWov3oT/0rzGhypAkTSAS6GTTJ+r4B/Pu4ZGuVeVhPftKICtSiiKBT6Ti+CYMPMZ8bQSps390jv+jl9ElCP0X6LXdjWR+GD+GPj0clQby2AOJOn7yULWot3YYQVXvU7iivUpsg3Io1jNQ1BYHCpWQKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=UwuJ6v5W; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="UwuJ6v5W"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TMCEAQ2208670
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 18:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=GOZu
	5NR42SpEsku8Ns1Xem+A9XCgYdtBxKbxW3wb/Q8=; b=UwuJ6v5WZJ0OeCqb38nZ
	HxEw2K5Cim53nr0/UyKGLlTxJ8iXCu7a1kzXow6FM8Jm2xVS/jS6fXhXw7NmrG+i
	6Ynjd0MEmmJHxai0llD5mTU106Dx+HBK2yTwvKbRxKZ0Gi3l2kG4Evjxx9XH5tnf
	U6xdc7bZuNMv8AdFXqojAJecp7t44lFRQjuiCn2fRWu3hGsG/u83f6ivFjj67M93
	DssaA27UFx5/Z6enDS2FA5FfbGcpreXwLfICcVDyOb0KSG3OGeelkvVpmMdzfyVV
	qhIQRMNBFt+9suOoW4qapI52ys14Wg13IPwJ73GHax4AgwXM6/Y2JPKDy3tT63tc
	zQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4efk2eragc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 18:54:10 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-914a8522bd2so1800355485a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 15:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780095249; x=1780700049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOZu5NR42SpEsku8Ns1Xem+A9XCgYdtBxKbxW3wb/Q8=;
        b=iP1OWzoejZiZ7+1/HXzuy8FIp7oaZjNYA3gsj1pWsEZjz4GRyxoWyR3FXWpgJZizMN
         7fIE1mYsl8orrF8lrr6flJg85mDm91VZY5ctQp91G1Vxsb5OScdRAZOg1UGGUs8zb/fq
         +Gpr1E7oOlai+y98MDUt53MY68SCaQCsB7NDuiQJMMqv74990eRMirUXcJyD0GdOVTUk
         FGoCxI4nlmcux/ylpFUDuXb920LGnckKpappzB2YdikZPiW8IOj6a364sjZ6IU+F88Rc
         NYDJ/zU4d8MNOBvBg4UA1OrITmdzPWjGEH9XwJQ8/2QdsyBByUWQuc+FsgENDNRjLsS3
         +ZPg==
X-Forwarded-Encrypted: i=1; AFNElJ9sLIsWTnesAkc60+lyYoDOzuCU8TdJhgZjANGp1vw6bGLsGLNIUQbPuYJZwUb5DZHJEzPGblUWL/NHRaQc@vger.kernel.org
X-Gm-Message-State: AOJu0YzUjLvthSiJdJfECYZzsw50OSPE0mOAQAm7dLjw3NdQ946nS4o2
	tlnna8hXjFtUVdFvx5adjq3bFq8pp57e4XvW+B/OrEpcJlSa0VXDAJJI/OL9CLQg90HZaeNHVti
	y2bBhUrpZwOys8DFfNJQmgoXnU2KxiZuKjOFHeCy/WYKIsjA78PgezwGYzs9yhm8=
X-Gm-Gg: Acq92OGLPgWjXloaeO2qqCUygJ72WYCg7UVEqs4xUUfpE8HK7rZqiVSlu4wLKtfB9jE
	4y9G+I/lzRQocqeeR1Q+pZSEmgoBdq7bkSDxs44h8yrh3JEh7gCKdvGPxqRMNlfuFZwyqG/V00Q
	2DHhmzHUOum8D3pf58df1Ro+AAIJIFkuPbOMGZY4bxPn8Xumim66SYFcqL4S364elRa+RWWAoza
	GWNBOdCwaXwxHsXs84XNhTGl3gcLFzJVaiZahEHlhmfRgzRMeGA6LdmOH7nM+o/Ferdap8D6wFv
	WXGvztAkGjN5ONbdYebMLXMyg79nvUVdavyl8xrAGFWFb5HXFFeb6XEbK9J67ELycWDJOJHtVBj
	QArNBmX7/wEfTOn7V3dqx+qCLTRf21UrDOcOujxwNQhTXBFg0o9WVksBS/Y2DIUQjs7N37chmcp
	yGRkHeXermpW2QW875UEL8WcNBog==
X-Received: by 2002:a05:620a:7005:b0:911:d96d:139 with SMTP id af79cd13be357-9152f91aae8mr628980585a.11.1780095249712;
        Fri, 29 May 2026 15:54:09 -0700 (PDT)
X-Received: by 2002:a05:620a:7005:b0:911:d96d:139 with SMTP id af79cd13be357-9152f91aae8mr628978785a.11.1780095249321;
        Fri, 29 May 2026 15:54:09 -0700 (PDT)
Received: from ?IPV6:2600:4040:974e:fe00:c8bb:325f:9d37:a5f? ([2600:4040:974e:fe00:c8bb:325f:9d37:a5f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91532628f87sm335923385a.35.2026.05.29.15.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 15:54:08 -0700 (PDT)
Message-ID: <fb59cca8-28b0-4231-a109-a6ae0ea12a03@columbia.edu>
Date: Fri, 29 May 2026 18:54:07 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/11] mm/filemap: split out folio wait and VFS code
To: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
References: <20260520-filemap-split-v1-0-c36ddc2b6cf2@columbia.edu>
 <3dxzu3ck5y3wxw4pp2qhzwwb6y3f7mwhvgxfpl56sokw4ymop7@xaaoxsa5yu5q>
 <ahg55Ei8Fc3iRsnA@infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <ahg55Ei8Fc3iRsnA@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIyOCBTYWx0ZWRfXy66XKVAJfjjT
 Ca/Dd0YRGk92Y2LAGNBLqMVqBAzz4TNn1iZexWOmQkDZ9kJwIgdZkid+cp8tSmXJUdmbh6bi0i1
 vCW0YK3Vc5FyHD/YR87Lu6EjT4zfJJyXAEhQW6RNyKc96Kuu1mxaoAIEoulW/K+JOMujWKEEc5q
 TUBsDd6en3pGJbkCqSDbiZUSlilRJaJUZ3nagCrI8XwDvSWZuAaC6mMVHG91ZFQvUFIXZ7pAoL2
 zqVs3H5uFmwkQHnh89z8UkFv7/zcDc+/YNdqgbCZRk0+yMxToApVpcP/g8i+5uTQnFiYDTrJQ86
 knoTE3vLgbnNli4R+Ei8RP87vmf8whUHozk0s3qZ3mM7ezRrrEyOuALeunhSXxRfH0k1pRV7VTF
 PIB57rQDOtWXJrbxOl21/5s9YnQxuPUC7jxEBKtBlYbC1iXmQV/FZD6qIwyV1oqeqhTykpPy2DK
 lhj5DHKAKTLllQzmBYA==
X-Proofpoint-GUID: -nYe5imDg-YzesFrpKpQ6OerOWUkUxcA
X-Authority-Analysis: v=2.4 cv=I5pVgtgg c=1 sm=1 tr=0 ts=6a1a1912 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22 a=lO0XnYq6BgjnjRCXdOAA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: -nYe5imDg-YzesFrpKpQ6OerOWUkUxcA
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11801
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=10 priorityscore=1501 phishscore=0
 suspectscore=0 lowpriorityscore=10 impostorscore=10 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290228

On 5/28/26 8:49 AM, Christoph Hellwig wrote:
> On Thu, May 28, 2026 at 11:22:37AM +0200, Jan Kara wrote:
>> Overall this makes sense to me. In particular I agree it makes sense to
>> move the file read/write helpers into fs.
> 
> I disagree very strongly.  Mixing default implementations with the
> higher level APIs is a really bad idea and leads to people taking
> stupid shortcuts and other layering violations.

fs/read_write.c already contains some of these "generic" function
implementations, including generic_write_checks(), which is called by
generic_file_write_iter() in mm/filemap.c. Right now the two files are
unnecessarily interdependent. I do think fs/read_write.c is the natural home
for these functions.

> Splitting up filemap.c makes sense, but I'd rather keep the generic copy
> into and out of the pagecache code with the MM infrastructure for it,
> as it is not VFS code, and making that clear to anyone touching the code
> is important.

About half the code moved is implementing direct I/O or multiplexing between
page cache I/O and direct I/O. It definitely shouldn't be in the page cache,
and I do think it is VFS code. The one exception I see is
generic_perform_write(), which is analogous to filemap_read() and should stay
in filemap.c (and probably be renamed to something like filemap_write()).
