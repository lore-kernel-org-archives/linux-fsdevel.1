Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=131.179.128.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795205011;
	b=bvNbvVi8xewjkrCXLPTs7lR/iRszRrRuIHXhKWz+eXqX7LY7LC9Imq4xY5mw0feCdgjP
	 hoWsy06zteyURFIuIoEZJL8/jo+152w175TsTQtxOFfyIb/2FtEBedogV18h7InoJMw2Q
	 ib2YVAK2zPLf+cvBQaqf0z9wFtJXCywncVpD2HrlyNXeerpU90nfXnN4mNqzAdACBfhQO
	 pIYU8lTDasxmhxDrht4lq8mw6AWSnsGUVJo+gcyxhqgVfuMkGjlciEb5pc9XcBEoBz2YA
	 iAu8izZT6TIozFFW14yIqO76gcGwmGCdhAjGzAwCf47oG2O34qdtJ8BoPHUw5XESrGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795205011;
	h=DMARC-Filter:Received:Received:Received:DKIM-Filter:DKIM-Signature:
	 X-Virus-Scanned:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=rfTCaKLxMMSZ5YvCl5KpT7gVEP+ZfpjqitLNNttFkPA=;
	b=bKDf5pVRasZOjdoi7/qv/sfQg06Nc9GbnkFCVKV5Om0lK8gk5nvqKAaUY9HzC3DFVnW+
	 pP1AG6by/RE/qdBFWf6UFSTVXh5Mk/1bmhiXjbskJVd6amrUzfS6eMvQ0EzXDwYY1iVQe
	 C6hE2Pvr2IPdCbb9emaGVoHUOgnH5e8cCPxyEQFNOJUVF/bTb/kq+ZF8pKmG5p3oNroPd
	 8weI/UPwcdzqBuwjzjD2Y3b6sv05BmS723C1i2GEmuSZFWrjVUWCjR85eR8aO+f7PbIS0
	 RRPpqpVvJnscZ6eniEmcuxGon0b15szneyKt39KCgfdDscrvldcwA1JKDfCQz+0iUhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.ucla.edu;
	spf=pass smtp.mailfrom=cs.ucla.edu;
	dkim=pass header.d=cs.ucla.edu header.i=@cs.ucla.edu header.a=rsa-sha256 header.s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C header.b=dLmKcf5Z;
	arc=none smtp.remote-ip=131.179.128.66
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D76606A6C8;
	Fri, 20 Nov 2026 20:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1D76606A6C8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.a=rsa-sha256 header.s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C header.b=dLmKcf5Z
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id F1F233C231D1D;
	Fri, 20 Nov 2026 12:03:23 -0800 (PST)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10032) with ESMTP
 id vEkFVQOL2ViN; Fri, 20 Nov 2026 12:03:23 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id C42553C231D3F;
	Fri, 20 Nov 2026 12:03:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu C42553C231D3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1795205003;
	bh=rfTCaKLxMMSZ5YvCl5KpT7gVEP+ZfpjqitLNNttFkPA=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=dLmKcf5Z6h42MdclFsk/Awb7HdntRCC50f/8kEZ3e+qmuZGFBgDZXQJ368H7MFZbj
	 nHRMPND6BES8Sy2FrNxragZF2TrJCniq4SNMn+csPxCxK8ZTCqOQWlJTnPcpC+VZEG
	 Ai1eX62I4wuNaIc3j9jNj+39wIS32qEr4KMMs23LD5FdHqzJ/uOTwFmBEBhV0Fs1TM
	 FWZQn5ZdOVTfMuzyN0327HbDvjJ97fIjd+FsQQoF3cRXHPeAF+hnjY84uOx86KiKLy
	 qyqUb8K0f0pHWGcBUbRBGnAzjXm1Gs6kv1vRlEnLgxqVHPLbhnJTMUjB3ffT+0nntU
	 lL/yfmSaBdkrA==
X-Virus-Scanned: amavis at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id PBfblUnHHEGL; Fri, 20 Nov 2026 12:03:23 -0800 (PST)
Received: from penguin.cs.ucla.edu (47-154-24-214.fdr01.snmn.ca.ip.frontiernet.net [47.154.24.214])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id 924F83C231D1D;
	Fri, 20 Nov 2026 12:03:23 -0800 (PST)
Message-ID: <9cabfb96-21d5-46a7-a0e5-df0908fa67c5@cs.ucla.edu>
Date: Fri, 20 Nov 2026 12:03:23 -0800
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
Subject: Re: [PATCH] fs: shorten I/O that would extend past the maximum file
 offset
To: Matteo Croce <technoboy85@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Ding Feng <dingf3ng@gmail.com>
References: <20261120184225.257554-1-technoboy85@gmail.com>
Content-Language: en-US
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <20261120184225.257554-1-technoboy85@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-11-20 10:42, Matteo Croce wrote:
> +	if (file->f_op->fop_flags & FOP_UNSIGNED_OFFSET)
> +		return count;

This means there's still a problem when reading past the maximum file offset of /dev/mem and other files with FOP_UNSIGNED_OFFSET, right? If FOP_UNSIGNED_OFFSET is set, are the file's own read/write methods expected to shorten I/O requests in this situation?

Thanks for looking into this, by the way.
