Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170810;
	b=ncgWP7L31fH7NDeMqaWG17sdsLMqEmvos37elRmg3FxJ3BRMHnXcYWlFKl3ejmy5V1YD
	 Vsfg1siU76UOsaYQ9J8yb9PH5PI1hQ7l4caSiyKsxcspPutcyMtjDeYe4sCQO/KT/31Ad
	 VzMb2UXo5/iWS4WTQJnmIgpTisDuXAu5PmaUsEylW2ySVyilb788lH+NvV7qGDMoMmP1w
	 FpoQTGavmEqST2nd+4965T4E3ASuXVSCpXAk0DQJXdxRy/MDxVYoziTbC9n1tF5ipIV1M
	 MFbrO490wLLhJ3gpPI1Ige8n+TTwplmFlX/AGFijE6RpkELH/HyeanJREUhkbjR9J+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170810;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ZYnaWZrPnp31G4iCGOrEON3WcVP3HCv6KeqKtTW95D8=;
	b=R8biNqTEIYeTkJy8hLC2ZlFRDnoJFolADhma4acxEyHhCynqyuVNm6BjnuhRIYQd2t0b
	 U2Afc3D4Pc9A22eyIReBDfCjO6VsWv0Eo5i65qQuvDUNZtgUuYbl+pAdrctn7sFbINW9b
	 4rnNl6XCjEcunfeUInOH3PSvghcvF43r1vGnbluDcsg6NwFo7UukFicF653sa80KMcbJW
	 1Pbji9ielMBeA0vQzH5jg9NddcLQ4UwOk5GEuXG2vy8ArUgK6UWoPBggaZZRkmHYgE/xo
	 0GGJfrJaHpYdWKEXNyfPVjPxT8p7G3aIJ/qsvHqBfgVi+1c9V3E/+4ARkL9GGm7C6Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMllMaIL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A886E606A325;
	Fri, 20 Nov 2026 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMllMaIL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F281F000E0;
	Fri, 20 Nov 2026 10:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795170809;
	bh=ZYnaWZrPnp31G4iCGOrEON3WcVP3HCv6KeqKtTW95D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OMllMaILUlLf9s3hvr093RPa75e/yAby83K3+l//mQZtOL9v47/aXwH8G+7Atu2gX
	 LqZs1PwMhRj/DKEE1SAteqAAZXXblvaLp8sbbC6USgHRDEzkHVyzB5Zkwq0cz5ehWW
	 DLW7dwV8Hiil8Q3et3norEw9gL5zo+DA8WCTRpjtR18b4N0bicAvyM8Fae60TiZpN3
	 jpNnQtECf2r7MabCZwspgM/XpL7iyp2/nUPata1gRHS8ONqIRjKr7iVGgJgSNLUw7r
	 3OPcy/RYe3bzqfD/y1eZW45g/c+1SYGgz1AvcUsAvjjd2lXuNuuBYHNLwFud78PBgf
	 cjy2RTHg+7Mjw==
Date: Fri, 20 Nov 2026 11:33:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?B?TcOpdmVu?= Car <meven29@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	=?utf-8?B?TcOpdmVu?= Car <meven@kde.org>
Subject: Re: [RFC PATCH v3 0/2] io_uring: add IORING_OP_UTIMENSAT
Message-ID: <20261120-vorfeld-formlos-nahbereich-00aebc4c5150@brauner>
References: <20261114104621.1186744-1-meven29@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261114104621.1186744-1-meven29@gmail.com>

On Sat, Nov 14, 2026 at 11:46:19AM +0100, Méven Car wrote:
> IORING_OP_FCHMOD was proposed in 2024 [1] and not merged. The same
> questions apply to fchmod and fchown, which a copy also needs, and a
> single setattr opcode could set the mode, owner and times in one
> ->setattr() call. I started with the times because a copy always sets
> them.

To me it seems strange to grow an io_uring opcode per attribute. What
makes the most sense to me is a common interface to set multiple
attributes in one shot that is shared between io_uring and the regular
system call path. IOW, an extensible struct based system call that takes
the mode, owner and times and does a single ->setattr() and an io_uring
opcode that uses the same struct. Then a copy sets everything at once
and userspace that doesn't use io_uring gets the same thing and it would
reduce the number of system calls for userspace and less work for
io_uring as well.

The other thing that this would allow is for filesystems to implement
multi-attribute changes in one transaction.
