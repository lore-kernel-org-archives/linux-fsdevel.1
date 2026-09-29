Received: from outbound.ms.icloud.com (ms-2001d-snip4-1.eps.apple.com [57.103.73.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2AC4F96BE
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 23:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.73.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726311; cv=none; b=F1LuxmQ6tqTUtkixDiVOX3uDyoEkbcmSuF7XVZ4TAoq0PNJAspF3qiTo/opkExU5vWrCydysgFNEHVJlJx0GeGNcE82bXljlaKX7ATXknOphaSFY6TXBvcCwqV5Coy52K9bH8/8HlpW6ChpkeKZyUnIEgl53XkFquIqVDKVGjxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726311; c=relaxed/simple;
	bh=PCFVVhpbKgBlB2d8gVhCP5nHYxJqOizJFbpI9n5pD9c=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=e3pLJYsImYQ5PP2EzfOt75cHgmFK222eYbt+U/HPf+VZbz+mpHd02i4DNnCM2KIcr7aVKKTFSRbV0ufGsmAblLD4QScj/oUWQnFgVmtW1M7j3GV7Al9Hk19KaWXbmoLJWLs4r2brRsVpInOqv6UEUzZ32XYhRJeB7hx8Eyr9C/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=qbCj9kkJ; arc=none smtp.client-ip=57.103.73.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="qbCj9kkJ"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-20-percent-1 (Postfix) with ESMTPS id C1B601800115
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 23:58:28 +0000 (UTC)
X-ICL-RepId: 01a0ef9b-0381-7c49-a50f-b1165e07c0ae
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQhMCkMFWRxIDVYCXgFLVxQEE1wJTkVBE1EKUgB3AlEcVg1XQ1QEX1BfHA4EVAddBV1WUAJaS0ATBEkTBVIHXU1WDUcPWB5cFBcVQENeCF4fTBwdDlgGEgBNCg42BlkFXglWA0MFNhIUXUVaDlsERxQXG1wAFwZbFARECl0EU1EWWEAeCQBYAF0NGVdVGgpUQVpVUFsFXgNAXEpQXFIPchlaFFwYU0VRH1RGExlOG1dNUBtfAkIP
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1790726309; x=1793318309; bh=W2hlmbzwZKn7CvC099iBnA07VriMtxRhjOW0JJpHQhU=; h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:x-icloud-hme; b=qbCj9kkJ9SirGxfulNyQBLK6fjLSPv6hv1RREzFD31dK+DPUrrHkFUT9nB7jY26z1ZYna+p+xjGARhrjHMiVruoB2BRNutL4vdjEENyM7JIofNaJd2i/PSt1sMqmkc62wucMHR2bhEA3oMrN3Rzng9AKUPIUs8ivJejLUDe5xruMRR5uIeTPO1P48Pr+tDQZK71x8R17MQ1IfKR8/cbiFPSkjGAIHqZYHV0r0FeryjlFR6ExJzU8LjZWqWpazOpRm+yt5iVCN9iMLg4Hii5LI5PVuMFMb5CwSOEeQC7aYHA6sUHwYCuuN1rkEZgUVYyMMabmHkJnDBybaviVwdMI4w==
Received: from [10.2.0.2] (unknown [17.156.208.39])
	by p00-icloudmta-asmtp-us-west-3a-20-percent-1 (Postfix) with ESMTPSA id 2AEAF180042E
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 23:58:28 +0000 (UTC)
Message-ID: <9038cfa8-d732-4ad8-af1c-c62510e2c1ed@icloud.com>
Date: Tue, 29 Sep 2026 16:58:26 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-fsdevel@vger.kernel.org
Content-Language: en-US
From: Kody Schram <kody.schram@icloud.com>
Subject: Question about Multi-file Compression in Btrfs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JMppDubIzahzEIINi14tKU4eMUP5TtD0
X-Proofpoint-ORIG-GUID: JMppDubIzahzEIINi14tKU4eMUP5TtD0
X-Authority-Info-Out: v=2.4 cv=J46nLQnS c=1 sm=1 tr=0 ts=6abc50a4
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=x7bEGLp0ZPQA:10 a=FaSUDvCwAnsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Y0nWq5sZCA44W3C5C2oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA5NSBTYWx0ZWRfX10zF5+V4t02u
 yeajnYp4i8MNprVBToVpyqCbghq4e0CvTfgkuUrqY0yy9qaC2JLnytqRyHbQzRIlgCeNISElcDw
 wyjolhnWo/jZ6wa63jOwL9dS5A4bC2zIyX/wLeIyqFvpc97YO8F0u+9NEFCMGdQcqfB5fqXs0od
 udxyXRgGWHdNYmnKVGX6PpliyAgZOgPTpOEU4VNLNJ1ATPpBrRIIxMyeDK/eu6eZgEVEch8NLXt
 kH6IySdP22Kvrc9do8+8/uR1NWdXEdaG9RluQPcF4GDqtQmmRoEhMOevZudIfDxjM8k8UyhREqa
 dZkQzaRzeEMWx3IuOTU1gSENQoPp/uig+CwHFwu9NMATdwerN18BohMeC7eK+w=
X-JNJ: AAAAAAABKs6icr3NYSRpdY7D+FJoJ2mrmbXuATD8EcqTXWBIIe/Q9UxccvMV904DwtwL5ZzBdp1t8f/dWbAiaxbQjMvKQzvsL/J8TSgfhfUabvPZdLDto6zNq96ghGAouL0fRC13ST24RHPP9u7KALan7TBt9qRZRBrQKFKl4fRpzcQrJdNCeZJwPI5XDtZ7WtILdIxSvd0Ooy7BGZffiP+rlcVTqVVGkK5x/T5AYOIxWF5Zbqe+ITeyhnxsohgF1X1Klwz1Vp9wVH81DDPW0FfrA1yjWZbWkmWtizJg7jPVIk3zb3sigGIGr55FozW1ekgMjxAF6ewzjV6EYvsf19Odz2/dOUHoFQUxl9wO11XlAqKXG8aparx5jqkSWCfdZ/dPKMy/l7LOA6uS4YmFmwe4qxnuXyA1XBTg7cVbiXZi4ix81R3RXjJzjK9GcgqCT4WQGl/Vp4WUmvaKHyUpKVJDaf2c6OkkAMx32nyqmi7wXZPE7SC3+PoXYlv4MhyQc49sidJvyy0A/kkQagczQYswtnIhaM58cmDfvXM4cL/YL9SGoYi7u/XBMo6XAlD3VR9wdJ9cNBWD8BjyM6TZmS3VvKLOKIaC0vI+b6+Q0zbpc/veeJklpa2bnQwxkTYXVXW3eB9pJvDQ+sgwjC+Oq2pZSb77U29wOitX80Q7rASgb8V0/u8zYqMF8Envv/D42gwd0BsULZ6415gIxEkkTFzwhXPmdoZ2Q9KX+DBpQf1co3DnVajYp9j1hI2HOhmJWCLqmI4oPL1P1ybIPkfn4oq/QhoOXnS8+S7z1FF2yTTt7tmPu8uHCqHU4FzgBdyCDtxS3GilDsUbu0kRWq4lVzn8+T/elhI3EMK9/1r7R8nvFOkfXagDF2wRknvcNV2RXEIuP1xe2zESEobIhSrUSVLXBrfX7BAYueRlmrLLtDhS3yqqhkXruMGO0wfVaWv+Ac/u6jVJAYG8+BAbelqzWfrC7aaG2L2
 Ff+aGArkTTvTuWIpkFiNfcGm2yHJyr9ERZXn7R8dznE4cZJbWVGwJIBscKEu8yIjIKi6k5Vf6YDaMOMTiX616A1j119Eccpxk2DjYU1PDC46iO77M7wZKF54RsDl3SmJ7k1nhKQu3zCKd+Ku7gux3e7djc6XJNKdflCHRE5ri9NaI1o51o/I8cqQuYVjC1xP+ldh4WCRWoqYSGd1P6xb9t/c+TA==

Hello,

I'm an undergrad CS student and I was hoping to have a question answered 
relating to Btrfs compression.

I understand Btrfs uses Zstd compression for files. However, I have been 
trying to learn more about this and have found ZAR files (Zstd archive 
files). These utilize the same underlying Zstd compression, but compress 
a group of files into a singular archive file with an internal file 
system mapping. This allows random access to files in the archive 
through decompressing specific blocks of the file, unlike other archive 
formats like .zip.

I would imagine this also enables more compression than compressing each 
file individually. I was wondering if Btrfs has ever considered enabling 
compression similar to this while still providing a standard file system 
interface for applications. This could enable more contextual based 
compression where folders known to be largely cold can be compressed 
into a single archive, and any writes afterwards can go through Btrfs's 
current copy on write system. After enough new changes have built up, 
using a command similar to `btrfs defrag` could garbage collect those 
changes into the compressed archive.

An example I've thought of is ~/.config in the user directory. These 
files are largely .toml/.yaml/.ini/etc, and I would imagine follow 
similar layouts and would compress nicely. Additionally these are are 
largely stagnant files, and wouldn't cause many new writes. And 
something like NixOS could heavily utilize this since most of its system 
is immutable by design as I understand it.

Let me know if this has been considered before, and what things I might 
have overlooked or trivialized.

Thanks,
Kody

