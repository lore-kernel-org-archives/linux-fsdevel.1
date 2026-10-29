Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793303995;
	b=qiuUVflONcCxV/MqfFdOYdGzKMlZqkFXFOa2haYj/nfzNDZaEqd0hnq3HP3Nkqp7/pfK
	 eQzt3taOIDAA10PE/Th6Yzr9OjUep5XjXl5R7JwLd2qcmP3Drl1A8hOyf/U38BMqEOMUT
	 fXSjRMNo1YhgAwfJpGJ2Ji07Xpj1Ttlj/UN2wf5g+cVNoIPV8Msg+xOB9E7giquFsF6sk
	 6toJMKZpDyZZACHmYBUkAnlcNIW3AHFp47XY+4lGrq0jKoYjCSEScSInchWTdxzSRNgpB
	 SUgXuNoTRqtSj9yooOn7hexTNi4DeCcxq1ezXJkfV3iJhrF+g/Kj23nMQs53Ynh0duA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793303995;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=5B1pRs1TT1dol3jmRtEh71EItN5sFEWKzrCNZiITCwc=;
	b=2IFNaLMzf50ZfokM1fZ1m5yXVQLYZkR/O5Obx2/grQULxaYzIBc04XoBt/rfANeQdBu0
	 nku8T5OH/e/EIgG6uEs29p9IdhbyWuO15aVrWRKzfkPsjG2npaiVb7Y7qMjSeFO92ZR7k
	 7imKLtP/EccxBaqdtHCBdnbUp2N5rogbExfbIVqrqbNFb1kyT8hcwpt15BEdVSb78sdPi
	 3UDcuQBLIJ+BS6vYHULFPStHAL7JOLzxtag16rH7i/qCCjkUWYSepEmoAvpWbfkq4eQ/c
	 oJcj9/l2FBwaftWHaJ2w8NG+R6ooBdGqEl0gpPCk2zFDk0QhNcpDPPd7oMlU2w6kgyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=cEsb5Hb4;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=kvAlNuhE;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501F3606A31A;
	Thu, 29 Oct 2026 19:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 501F3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=cEsb5Hb4;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=kvAlNuhE
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 641EF26F7699;
	Fri, 30 Oct 2026 04:59:52 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1793303992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5B1pRs1TT1dol3jmRtEh71EItN5sFEWKzrCNZiITCwc=;
	b=cEsb5Hb4R+scdGP3GdvO1GPj9W4lswR9M8dvEyj/WmcK1rlnlFbWUUeOKi5ZPfCAfmh9za
	Tzo5dbwy/VsdaVR9hE2pqN9TSDye661wFA8/yQwYNqrlGBRiV6mqQJvsS3V19wDNdU9GwX
	/I5xMnqhTNmDZzQxoEzUwLUeUKusE9ZHHrXj3HNg1GtHvXcRIYkroYtZiKw0qhqDHSXHPy
	jzJRtR6lpg1uiD2rrAt8V8AOXdOydfvwwLMAhGYTdllea0CwygnX3fTM4KR7xRdyla5MAA
	NZcqAMBawFSc9+bm8Yo+YUdAas3dkw+UQ8tnhOznpVGcZPRtSBR55+XfPBu0GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1793303992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5B1pRs1TT1dol3jmRtEh71EItN5sFEWKzrCNZiITCwc=;
	b=kvAlNuhEZTFbyscdI7EtuHPO97htJtr9C3GscF5CoQGzVCT8ymHOx0/vCoUkPQPCCEcAWa
	tjGq3yfqSCMdBaAg==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id E24B0E000FB;
	Fri, 30 Oct 2026 04:59:51 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id D1B7022001E2; Fri, 30 Oct 2026 04:59:51 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hungyu Lin <dennylin0707@gmail.com>,  brauner@kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: fix parent link count when replacing a sibling
 directory
In-Reply-To: <20261029121535.3347dc93905f38b23aada5cb@linux-foundation.org>
References: <20261028211626.26103-1-dennylin0707@gmail.com>
	<87fqxpdp60.fsf@mail.parknet.co.jp>
	<20261029121535.3347dc93905f38b23aada5cb@linux-foundation.org>
Date: Fri, 30 Oct 2026 04:59:51 +0900
Message-ID: <874ie4tgzs.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Andrew Morton <akpm@linux-foundation.org> writes:

> On Thu, 29 Oct 2026 14:57:43 +0900 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
>> Hungyu Lin <dennylin0707@gmail.com> writes:
>> 
>> > vfat_rename() and do_msdos_rename() adjust parent link counts only when
>> > updating the dotdot entry for a move between different parents. Replacing
>> > an existing empty directory in the same parent also removes a
>> > subdirectory, but leaves the parent's link count unchanged.
>> >
>> > For example, renaming one of two sibling directories over the other
>> > leaves the parent with four links instead of three. stat and ls report
>> > the stale count, and find -links 3 does not match the parent.
>> >
>> > Drop the parent's link count for this case after the source entry has
>> > been removed successfully. Leave cross-parent renames, regular files
>> > and the existing error paths unchanged.
>> >
>> > Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
>> 
>> Looks good. Thanks.
>> 
>> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>
> Thanks.  Sashiko asked a thing:
> 	https://sashiko.dev/#/patchset/20261028211626.26103-1-dennylin0707@gmail.com

Hm, sure. It is possible what sashiko says. This patch itself should be
ok though.

Hungyu, can you add ->i_nlink check for corrupted dir?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
