Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689B62C21C7;
	Thu,  2 Jul 2026 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009132; cv=none; b=NBnJpcutE0WXLCZCw/FFcbwSSTgdkfEo0rNPQUuVJg45nTPiR+tYzIVhT/U/QpXY0LfL1h4GTseqT/2oAnuYdD8AgdJ5jv3KN4fLejCycqG3cLiwblO370wv/WN0QoCPnsGCa3wqnBKudtTXBdsccWbvFYep3PMrhT7KgzJBSZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009132; c=relaxed/simple;
	bh=7htcDs/00c25hrTxhtL6vvRMJZp3El53VXx2WaqiFJY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ewuz9WiQhefiReFHzkjDcVroCi/yHWsGD7+t5yFfYlrjh0y/fH0Zu5q5oZOJ7KeIJ5ff/y3zaLh/QfILvxJKc6RWtCNYKTJKuvzGQYmmrdPs1oteIk6e1AqEYC+6e3FICqzeYd/+ofTblvKslAldWZJDDuHWlIYOByWtQcFOPS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyRFsJ0q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyRFsJ0q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630E71F000E9;
	Thu,  2 Jul 2026 16:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783009131;
	bh=7htcDs/00c25hrTxhtL6vvRMJZp3El53VXx2WaqiFJY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=DyRFsJ0qPwfI55AIV2ZDqEkfnyZVBzGiYoKD3IZOhZ1Cj0oQnY9Nuhr+y0h3b5UI5
	 2mdTM5hyA5pBOp1CFLLrJmgcmxFmHe5b4eTGMnM0lp7XUJe4Xq80p9htog7nR5NYZ6
	 5gLyavR4Cx3NKu6wfEtrHhqPGIWyVJwf/ukOepmrPcRGNHe4KwqzADHr01BUQrHq5G
	 ovcVugYhwzPgotFM7Gmy9YTBpe1F1bk73jtm+tuw9ExdMyXtM/yOMDfiBwrsSUgs6m
	 soXZNVsM1M1KMQ3Z8TDeNdPkePG8NZLbX03WNjs/bwM00vpLvRyM6pdhtSTJnPI6fG
	 DbUjhZeyI909Q==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
From: Christian Brauner <brauner@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
 Jeff Layton <jlayton@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <akZzDfK-yr5ErVJT@lucifer>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <5e7b9d23-4291-48fb-bdc6-47db82d33c80@kernel.org>
 <20260702-seekrank-stilrichtung-mitentscheiden-69a64ee097ec@brauner>
 <1f29f48d-b9ff-4de2-a392-dc05781728be@kernel.org>
 <akYz2aMIco1fbD-t@lucifer>
 <54d3a698-a275-488e-ad36-ef423db30f70@kernel.org>
 <20260702-weitreichend-aufgearbeitet-flausen-fd92f38bbba0@brauner>
 <akZqigap0GTOSkyx@lucifer>
 <20260702-angewachsen-glatze-kassen-61b7761f6564@brauner>
 <akZzDfK-yr5ErVJT@lucifer>
Date: Thu, 02 Jul 2026 18:18:45 +0200
Message-Id: <20260702-jagdrevier-halfen-paragraf-442896b3a5a0@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=289; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7htcDs/00c25hrTxhtL6vvRMJZp3El53VXx2WaqiFJY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS59WeUW4pOVuV1sC9zub3ozckjz8VWPDXdq6ZpfU1z7
 1K/wwrXOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby2Y+R4d/cd4YtZp8un9fe
 peUU9zRDfp/e+cv/pX28cza+VN1itoHhf6rD3E2dj9TfX/j1s8inlDukYG+VucMyS/mtkraz5uz
 JYAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> I don't understand that at all. The coding assistants document is not being
> deleted, and if you read https://docs.kernel.org/process/generated-content.html
> you can see it doesn't enforce tags.

I think that was a misunderstanding. I just wasn't clear on what you
wanted to do.

