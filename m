Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6A02D6E44
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778455078; cv=none; b=Mc6QRDHJD6RscHK2KMdKsAUIyltqpbsP75YNx81qsfPMIjHzjvS8jEldp5xBp5EHL8LUX0VpHvWFCHqqqKSMdE1llUNa19g4BWDzxTCDOpqXcZfKCOng+r6hkESBp7Drq7OqSVUbStn1gM0QB5JBDox9OAdgLbYh3JGtOHjsr8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778455078; c=relaxed/simple;
	bh=CaDMIVtw6ZPSJhJ0B8yqf5AoWV+360LsdaODtMuJfuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLl0sIS0545+BGn8vdM9LchNXCBdXrM+yOpv0DBmQSFhc6QCnZqTsaG3QW43aS11zfBGXiElYIyc5r9YCv7j2ZFTCec8ri6NAZ+wmWAnHMkPkHHG+UTAD6YblloLJdXdgH0eheVme5m22biGrHSjAu1iWyek1EIZ5pl8Ejooz2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 5C57B1D490;
	Sun, 10 May 2026 23:17:55 +0000 (UTC)
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id LtOcAyMSAWpHMwMA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Sun, 10 May 2026 23:17:55 +0000
Message-ID: <91382b9c-52bb-41c7-9ccd-9045a1827b89@dev.snart.me>
Date: Mon, 11 May 2026 08:17:54 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] exfat: add volume limit bounds checks
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260505122808.728020-1-dxdt@dev.snart.me>
 <PUZPR04MB63168F494EE6F2061377420D813C2@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: David Timber <dxdt@dev.snart.me>
Content-Language: en-US, ko
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
In-Reply-To: <PUZPR04MB63168F494EE6F2061377420D813C2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/26 21:04, Yuezhang.Mo@sony.com wrote:
> I checked the code further and found that exfat_zeroed_cluster()
> already has a similar check, but it is only for directories and
> does not check the size of the block device.
>
> I think we should also add a check here, similar to the check
> in exfat_zeroed_cluster(), to check if the last cluster exceeds
> the device size. This way, the check will apply to both files and
> directories, and the check in exfat_zeroed_cluster() will no
> longer be needed.
Valid points. Redundant checks hurt consistency.

The existing checks can be changed to WARN_ON() later on, but I think
the priority for now should be preventing silent data loss from users
inadvertenly mounting a truncated volume.

Let's see if there are more checks like these in the codebase.
