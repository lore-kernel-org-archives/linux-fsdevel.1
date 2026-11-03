Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694013;
	b=t04UcOJnbSzfKkAa32MKmSqXsXo03p/oxwOBcCaMRXbvb00UffNIaVgdvLvmM2bOaFaX
	 lmv+bfaDPbsC1L1Ds6JqlA5FfY+ldTz9S1YFrBWISrBKiGvseb8M61Zt6W2lsPb61ibdH
	 wRmy4XBNVveM6LxrVhEcoozaIh5fH0E7ltA13oU7j1pAEbaSMSYDihhSleH0mmVBVUnbt
	 q18Pu5EV2h7hM046eWPec4R9Nx/TZQNOrpuEm5zNlXpxAWniEY0m7peX38hj56y20jI1R
	 ud5t1j7M6TAfr6F5r58BZS3xglQN3Qc5WxaQ5jG8O8rBF0QTgnvCdoIoO3Mkfw6dgFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694013;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=U9dKT/OeHASCfZZbWZRBlpvUNTqDgXCTk6is90HdXaQ=;
	b=kGDQMHxkUWdckgKxxS3JajdHDhpsrH1rvaN37zlAeTTgLBdEcI2gW9+h/RZqYa4qKb75
	 YMFgoeItBJCbhtsWh+Aj+UjhqgC9BvnmnZDNhr4iBV1EKvaitkz9ieAC2FI43PKZUM7fl
	 q/dMbRGcAMmG9/jZxI2puJT9RSiqlzf+rm72jlXNAkLiaO0tDX/XiOe3w6QeI6HSwrjLt
	 G90nM0nSRiOSHSPgPMta9ZC5/Fb5JEWfJhZ1+csdYs3HUYYY5eLEoDCHJade5ZHwQ/0rd
	 0Xc5EymkjU+P1W9o093CA37gdfu1kjkjGTsdkdPu6wDEQmWVmFgkVMYTkKecEJ6jaCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=T9XmblQ8;
	arc=none smtp.remote-ip=212.227.17.11
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DC6606A329;
	Tue,  3 Nov 2026 08:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7DC6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=T9XmblQ8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1793693994; x=1794298794; i=markus.elfring@web.de;
	bh=U9dKT/OeHASCfZZbWZRBlpvUNTqDgXCTk6is90HdXaQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=T9XmblQ8e2iDl6nrc43IX1jWvgY1aNsB3CnvxtLFK7jo9jYH6FnP8r5iPx/D57My
	 ZFbkMYfKJsBN2rHtq9JE2RvAlFVvrf95ZySQPhQvh4sU06dmNG+1FIDY046F/aROq
	 VUoWZpUGASlckytpmP3XBhFOHIAFKd5EpdSC41YP966ONDznLnNaoh03Vrz5CmLHs
	 6TE+4CzsclbtWEvht6KIEQiH2FzlUh4mF2CZVluDTfXDwiYFOCdDDJmYYap9yVL9n
	 Kpp+D8XvYe99AFC1WCpwUSoLSNdm6/6VUUfj3EzCnk6yWo/ogRLJYu0OwCC+uicTR
	 Vi4lYluzeLbgh6gU4A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mq184-1wkzVL2Lxa-00cgyl; Tue, 03
 Nov 2026 09:19:53 +0100
Message-ID: <7c1d70fc-ea04-4338-b1d8-f2ad12123cf6@web.de>
Date: Tue, 3 Nov 2026 09:19:41 +0100
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
Subject: Re: [PATCH v2] hfsplus: free failed b-tree nodes in hfs_bnode_put()
To: Song jeonghak <thdwjdgkr123@gmail.com>, linux-fsdevel@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Viacheslav Dubeyko <slava@dubeyko.com>, Yangtao Li <frank.li@vivo.com>
Cc: syzbot+98547b0428b6a6a3467c@syzkaller.appspotmail.com,
 LKML <linux-kernel@vger.kernel.org>, Edward Adam Davis <eadavis@qq.com>,
 Shardul Bankar <shardul.b@mpiricsoftware.com>
References: <20261103022522.21918-1-thdwjdgkr123@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261103022522.21918-1-thdwjdgkr123@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mBxjVR6xP5TjdzeiyaFLd0UPb/G8926l+mM4B6Z3XdrNgdjyGrs
 qIRoGCSBrexoRdzuAdV4gymHH7EXQoV2u81iiL0qGTuvMz2WapXbz8RT8L2R4J+8tnTTM4I
 mRpN8jhuceW5S3SaF1qJAA8r6awr4U753exQnvoMR5iKDe33Nt/+teoiMPJm5EnQAjZpXLE
 r7s5t+FVJ1MhHqrEojtqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H/9z1z86Vls=;OSi7kVCBFWGjUZ67NifhBPVmk3L
 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
 ymwh7gNJlYwL1IBnzO0DSZ9jDtiCeU1yJcGQ==

=E2=80=A6
> +++ b/fs/hfsplus/bnode.c
> @@ -702,6 +702,14 @@ void hfs_bnode_put(struct hfs_bnode *node)
>  			hfs_bnode_free(node);
>  			return;
>  		}
> +
> +		if (test_bit(HFS_BNODE_ERROR, &node->flags)) {
> +			hfs_bnode_unhash(node);
> +			spin_unlock(&tree->hash_lock);
> +			hfs_bnode_free(node);
> +			return;
> +		}
> +
>  		spin_unlock(&tree->hash_lock);
>  	}
>  }

Would you dare to use an additional label in such a function implementatio=
n?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv7.4-rc1#n526
https://elixir.bootlin.com/linux/v7.3/source/fs/hfs/bnode.c#L513-L542

Regards,
Markus
