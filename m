Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235CF3F8243;
	Thu,  9 Jul 2026 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586821; cv=none; b=cydUjkAU2z2q3Ku2FglJhDi5+GirEXmik6fsf0PVfH1suBCxlqQPSBnOfPF8k9qHqZZOgDkPxyaCJjkic4ickC7Lh1Pou8sz9tzwu24wjTT6HQrGaxrnEpVfs2fgDTHLdyijDBGmg4EkXuczNNvCMRMVh5IZUV7qLC7k2Je6Vwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586821; c=relaxed/simple;
	bh=AzAQtl4Trv2My5JPBvdfgIXHoc/Oeyu9y0cA3CW67k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3W26FhipaEEgLyJgGgViQbbUuZG8ZowlsOEJNZBZko4E+WVeoVpsNi1JZ05GHks78OnoJYDU5JUEPGY9WwxhRcOg4cdxBrAnZUu31cAnfsAsI9ZWPZ6kwytcMbVYnlZ82k5lfPQ8XMQJjQaK3OFo54BWc7pKFz/rBc8dHALjHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBSldxOd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBSldxOd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B1E1F00A3F;
	Thu,  9 Jul 2026 08:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783586818;
	bh=mRZq5csL5hUNDy0QIxQvRraRTIooykr0ndYA3Ihtjl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HBSldxOd1OT5zXPN3a1odB2dmyiw8TrN+4d1Gw7m3d/CL9q66iVrXfGiiTtI9wiCO
	 EeFUp5cVScV+TNykS0qn9JfgUMavTojFnkakG28zvB9WDrXLadsrV95yPNDySkp/iP
	 hwQfAQsUZOqTJ1t/yChGxMqchDFohGzCwJKID7Wbt75x17NVBqZpj3Yt18U8c6yUTP
	 1Wp4TjpxUysxyteciKfm6Q/RXCSk2Ddhm03NiDFqzxGrpIL5ZiY0OwBX/Nba+YLTqN
	 2QZgNe2XSyKOfhnbRYf8/vaauCmhJsk5YfnmZPF6qlVLOcZx+IcL8WsyzhWdPAh9HQ
	 47khgETVRVZEw==
Date: Thu, 9 Jul 2026 10:46:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: david.laight.linux@gmail.com, jack@suse.cz, jannh@google.com, 
	kees@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mail@johnericson.me, shuah@kernel.org, 
	viro@zeniv.linux.org.uk, Gemini <assistant@google.com>
Subject: Re: [RFC PATCH] fs: binfmt_misc: introduce eBPF-based matching and
 interpreter selection
Message-ID: <20260709-quizsendung-glasdach-ausmerzen-05ebd412a86d@brauner>
References: <20260704-kochkunst-hauswand-blass-7226e9443a9f@brauner>
 <20260704211409.1978485-1-farid.m.zakaria@gmail.com>
 <20260706-uhren-raubbau-sinnkrise-e40a8337414b@brauner>
 <CACCo2jm5=xrQNfak=TdO=2oh0DC5pe+atj=UfuTa8Y9s8GVkqg@mail.gmail.com>
 <20260707-campieren-fingen-himbeeren-e4b682bd8e63@brauner>
 <20260707-wortreich-kanal-zensor-9386ef4f38f7@brauner>
 <DJSPBVXTF02G.3SKLB9EO89GPT@gmail.com>
 <20260708-welken-dystopie-ertrugen-56a3b5f7ab66@brauner>
 <20260708-kordel-laben-kopfhaar-1c0dd234aae5@brauner>
 <DJTQTPG7QZSH.1YIDYKL3O985U@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7accz5oj66ddjm3r"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DJTQTPG7QZSH.1YIDYKL3O985U@gmail.com>


--7accz5oj66ddjm3r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 08, 2026 at 09:07:55PM -0700, Farid Zakaria wrote:
> On Wed Jul 8, 2026 at 9:47 AM PDT, Christian Brauner wrote:
> > On 2026-07-08 11:14 +0200, Christian Brauner wrote:
> >> On 2026-07-07 15:44 -0700, Farid Zakaria wrote:
> >> > On Tue Jul 7, 2026 at 12:45 PM PDT, Christian Brauner wrote:
> >> > > On 2026-07-07 13:34 +0200, Christian Brauner wrote:
> >> > >> On 2026-07-06 09:47:53-07:00, Farid Zakaria wrote:
> >> > >> > On Mon, Jul 6, 2026 at 9:01 AM Christian Brauner <brauner@kernel.org> wrote:
> >> > >> > 
> >> > >> > > Ignoring the blatant bpf abuse here I think this is quite workable. So
> >> > >> > > this can be turned into an actual design and patch imho...
> >> > >> > 
> >> > >> > Glad to see you think this proposal is in the right direction.
> >> > >> > Just for my edification, when you say "balatant bpf abuse", you mean
> >> > >> > how it abuses the socket bpf type?
> >> > >> > If so, do you have any guidance on a new type or should I just take a
> >> > >> > stab at it.
> >> > >
> >> > > I drafted a POC for you that should be closer to how this should look
> >> > > like with the bpf people in Cc. I'll let you lead from now on. I just
> >> > > wanted to help you out and illustrate a more viable direction. Might be
> >> > > that the bpf people want it done differentely. Let's see.
> >> > 
> >> > Cool. I just saw the POC.
> >> > (I'm trying out aerc to view the patch series. I will also try b4, I've
> >> > never set it up before)
> >> > I will rework my qemu demo to use the struct_ops and go through my own
> >> > testing to see it work.
> >> > 
> >> > That looks very similar to what I was researching with an LLM. I was
> >> > just going over the idea of struct_ops bpf (a new concept to me) and
> >> > using traditional bpftool load, a new bpf program type and kfuncs.
> >> > 
> >> > You put out a surprising amount of polished code -- thank you.
> >> 
> >> I would not call this polished and it also lacks any tests... I've not
> >> given the locking much thought and maybe there's easy wins on the table
> >> I haven't been considering.
> >> 
> >> > I would have had to lean on an LLM (heavily) and from the patches I've
> >> > put up so far they still have quite the gap to cover in terms of polish.
> >> 
> >> This isn't my first bpf ride in both kernel and userspace.
> >> 
> >> > What does "take it from here" mean in practicality?
> >> 
> >> Bring it over the finish line so I can merge it into my tree. :)
> >> If the bpf people have no comments or worries than we're done. If they
> >> want changes I'd appreciate if you could make them and slap you
> >> Co-developed-by onto the whole thing as necessary.
> >> 
> >> Also, please ensure that this works for all the cases you're
> >> considering.
> >
> > I have another cleanup series for binfmt_misc btw. That code is quite
> > old. There might be a few additional series coming out of this work that
> > we base the bpf bits on.
> 
> Sounds good. I just saw the patch series.
> My plan at the least by the weekend is to:
> * apply your binfmt_misc cleanup series
>   * I will try b4 with aerc. Here  is my config if anyone wants to crib it [1].
> * apply your POC series for the bpf to validate
> * make any changes if necessary or just add selftests if it works as is
> 
> [1]: https://github.com/fzakaria/nix-home/blob/aaee67c3a6d035d06a62cb75392657563de58f4a/users/fmzakari/aerc.nix 

I hade some vibe-coded tests somewhere. Let me see if I can find them...
Ok, appending them. There's an elf-section parsing test and a $ORIGIN
test.

--7accz5oj66ddjm3r
Content-Type: text/x-csrc; charset=utf-8
Content-Disposition: attachment; filename="elf_sections.bpf.c"

// SPDX-License-Identifier: GPL-2.0
/*
 * elf_sections.bpf.c - walking ELF section headers from a binfmt_misc_ops
 * program.
 *
 * Demonstrates full section-table parsing via the file dynptr: locate a
 * section by name (through e_shstrndx/shstrtab) and read its contents.
 * The demo looks up ".comment" and dumps it, then declines so the binary
 * is loaded normally.
 */
#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>

char _license[] SEC("license") = "GPL";

#define EI_CLASS	4
#define ELFCLASS64	2
#define SHT_NOBITS	8
#define SHN_UNDEF	0
#define SHN_LORESERVE	0xff00
#define MAX_SHDRS	64
#define SEC_NAME_MAX	64
#define DUMP_MAX	64

extern int bpf_dynptr_from_file(struct file *file, __u32 flags,
				struct bpf_dynptr *ptr__uninit) __ksym;
extern int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr) __ksym;

/* Look up a section by name; @name_len includes the NUL. */
static __always_inline int find_section(struct bpf_dynptr *dp,
					const struct elf64_hdr *ehdr,
					const char *name, __u32 name_len,
					struct elf64_shdr *out)
{
	char nbuf[SEC_NAME_MAX];
	struct elf64_shdr sh;
	__u64 shoff = ehdr->e_shoff;
	__u32 shnum = ehdr->e_shnum;
	__u64 stroff, strsz;
	int i, j;

	if (!shoff || !shnum || shnum >= SHN_LORESERVE)
		return -1;
	if (ehdr->e_shentsize != sizeof(sh))
		return -1;
	if (ehdr->e_shstrndx == SHN_UNDEF || ehdr->e_shstrndx >= shnum)
		return -1;
	if (!name_len || name_len > sizeof(nbuf))
		return -1;

	/* The section-name string table. */
	if (bpf_dynptr_read(&sh, sizeof(sh), dp,
			    shoff + ehdr->e_shstrndx * sizeof(sh), 0))
		return -1;
	stroff = sh.sh_offset;
	strsz = sh.sh_size;

	bpf_for(i, 0, shnum) {
		bool match = true;

		if (i >= MAX_SHDRS)
			break;
		if (bpf_dynptr_read(&sh, sizeof(sh), dp,
				    shoff + i * sizeof(sh), 0))
			return -1;
		/* Name (incl. NUL) must fit inside shstrtab. */
		if (sh.sh_name >= strsz || strsz - sh.sh_name < name_len)
			continue;
		if (bpf_dynptr_read(nbuf, name_len, dp, stroff + sh.sh_name, 0))
			continue;
		bpf_for(j, 0, name_len) {
			if (j >= SEC_NAME_MAX || nbuf[j] != name[j]) {
				match = false;
				break;
			}
		}
		if (!match)
			continue;
		*out = sh;
		return 0;
	}
	return -1;
}

#define FIND_SECTION(dp, ehdr, lit, out) \
	find_section(dp, ehdr, lit, sizeof(lit), out)

SEC("struct_ops.s/load")
int BPF_PROG(elf_sections_load, struct linux_binprm *bprm)
{
	char data[DUMP_MAX] = {};
	struct elf64_hdr ehdr;
	struct elf64_shdr sh;
	struct bpf_dynptr dp;
	__u32 n;

	if (bprm->buf[0] != 0x7f || bprm->buf[1] != 'E' ||
	    bprm->buf[2] != 'L' || bprm->buf[3] != 'F' ||
	    bprm->buf[EI_CLASS] != ELFCLASS64)
		return 0;

	if (bpf_dynptr_from_file(bprm->file, 0, &dp))
		goto out;
	if (bpf_dynptr_read(&ehdr, sizeof(ehdr), &dp, 0, 0))
		goto out;

	if (FIND_SECTION(&dp, &ehdr, ".comment", &sh))
		goto out;
	/* SHT_NOBITS (.bss-like) sections have no file content. */
	if (sh.sh_type == SHT_NOBITS || !sh.sh_size)
		goto out;

	n = sh.sh_size;
	if (n > sizeof(data) - 1)
		n = sizeof(data) - 1;
	if (bpf_dynptr_read(data, n, &dp, sh.sh_offset, 0))
		goto out;

	bpf_printk("elf_sections: .comment @%llu +%llu: %s",
		   (__u64)sh.sh_offset, (__u64)sh.sh_size, data);
out:
	bpf_dynptr_file_discard(&dp);
	return 0;	/* observer only: always decline */
}

SEC(".struct_ops.link")
struct binfmt_misc_ops elf_sections = {
	.load = (void *)elf_sections_load,
	.name = "elf_sections",
};

--7accz5oj66ddjm3r
Content-Type: text/x-csrc; charset=utf-8
Content-Disposition: attachment; filename="nix_origin.bpf.c"

// SPDX-License-Identifier: GPL-2.0
/*
 * nix_origin.bpf.c - $ORIGIN-relative PT_INTERP resolution
 *
 * A binfmt_misc_ops handler that makes relocatable (Nix-style) ELF
 * binaries work: if PT_INTERP starts with "$ORIGIN/", the loader is
 * resolved relative to the directory of the binary being executed and
 * selected via bpf_binprm_set_interp(). Anything else is declined so
 * regular binaries fall through untouched.
 *
 * Activate with:
 *   bpftool struct_ops register nix_origin.bpf.o /sys/fs/bpf
 *   echo ':nix-origin:B:nix_origin::::' > /proc/sys/fs/binfmt_misc/register
 */
#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>

char _license[] SEC("license") = "GPL";

#define PATH_MAX	4096
#define EI_CLASS	4
#define ELFCLASSXX	2	/* ELFCLASS64; flip to 1 for 32-bit */
#define PT_INTERP	3
#define MAX_PHDRS	64

#define ORIGIN		"$ORIGIN"
#define ORIGIN_LEN	(sizeof(ORIGIN) - 1)

#define ENOENT		2
#define ENAMETOOLONG	36

extern int bpf_dynptr_from_file(struct file *file, __u32 flags,
				struct bpf_dynptr *ptr__uninit) __ksym;
extern int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr) __ksym;
extern int bpf_path_d_path(const struct path *path, char *buf,
			   size_t buf__sz) __ksym;
extern int bpf_binprm_set_interp(struct linux_binprm *bprm, const char *path,
				 size_t path__sz) __ksym;

struct scratch {
	char interp[PATH_MAX];	/* PT_INTERP as embedded in the binary */
	char path[PATH_MAX];	/* d_path of the binary, becomes the result */
};

/* Keyed by pid: execs run concurrently and the program can sleep. */
struct {
	__uint(type, BPF_MAP_TYPE_HASH);
	__uint(max_entries, 512);
	__type(key, __u64);
	__type(value, struct scratch);
} scratch_map SEC(".maps");

static const struct scratch zero_scratch;

SEC("struct_ops.s/load")
int BPF_PROG(nix_origin_load, struct linux_binprm *bprm)
{
	__u32 isz, sfx, rsz, slash;
	struct elf64_phdr phdr;
	struct elf64_hdr ehdr;
	struct bpf_dynptr dp;
	struct scratch *sc;
	bool found = false;
	__u64 id;
	int ret = 0, len, i;

	/* Cheap reject from the prefetched header. */
	if (bprm->buf[0] != 0x7f || bprm->buf[1] != 'E' ||
	    bprm->buf[2] != 'L' || bprm->buf[3] != 'F' ||
	    bprm->buf[EI_CLASS] != ELFCLASSXX)
		return 0;

	if (bpf_dynptr_from_file(bprm->file, 0, &dp))
		goto out;

	if (bpf_dynptr_read(&ehdr, sizeof(ehdr), &dp, 0, 0))
		goto out;
	if (ehdr.e_phentsize != sizeof(struct elf64_phdr))
		goto out;

	bpf_for(i, 0, ehdr.e_phnum) {
		if (i >= MAX_PHDRS)
			break;
		if (bpf_dynptr_read(&phdr, sizeof(phdr), &dp,
				    ehdr.e_phoff + i * sizeof(phdr), 0))
			goto out;
		if (phdr.p_type == PT_INTERP) {
			found = true;
			break;
		}
	}
	if (!found)
		goto out;

	isz = phdr.p_filesz;
	if (isz <= ORIGIN_LEN + 1 || isz > sizeof(sc->interp))
		goto out;

	id = bpf_get_current_pid_tgid();
	if (bpf_map_update_elem(&scratch_map, &id, &zero_scratch, BPF_ANY))
		goto out;
	sc = bpf_map_lookup_elem(&scratch_map, &id);
	if (!sc)
		goto out_del;

	if (bpf_dynptr_read(sc->interp, isz, &dp, phdr.p_offset, 0))
		goto out_del;
	if (sc->interp[isz - 1] != '\0')
		goto out_del;

	/* Not "$ORIGIN/..."? Decline, the elf loader owns it. */
	if (sc->interp[0] != '$' || sc->interp[1] != 'O' ||
	    sc->interp[2] != 'R' || sc->interp[3] != 'I' ||
	    sc->interp[4] != 'G' || sc->interp[5] != 'I' ||
	    sc->interp[6] != 'N' || sc->interp[7] != '/')
		goto out_del;

	/*
	 * From here on the binary is ours: resolution failures fail the
	 * exec instead of falling back to binfmt_elf, which would resolve
	 * the literal "$ORIGIN/..." relative to the caller's cwd.
	 */
	ret = -ENOENT;
	len = bpf_path_d_path(&bprm->file->f_path, sc->path, sizeof(sc->path));
	if (len <= 0 || len > sizeof(sc->path))
		goto out_del;
	/* Unreachable or unlinked ("... (deleted)") binaries can't resolve. */
	if (sc->path[0] != '/')
		goto out_del;

	/* $ORIGIN = dirname of the binary. */
	slash = 0;
	bpf_for(i, 1, len - 1) {
		if (i >= sizeof(sc->path))
			break;
		if (sc->path[i] == '/')
			slash = i;
	}

	/* Splice the suffix (leading '/' and NUL included) onto the dir. */
	sfx = isz - ORIGIN_LEN;
	rsz = slash + sfx;
	if (rsz > sizeof(sc->path)) {
		ret = -ENAMETOOLONG;
		goto out_del;
	}
	bpf_for(i, 0, sfx) {
		__u32 s = ORIGIN_LEN + i, d = slash + i;

		if (s >= sizeof(sc->interp) || d >= sizeof(sc->path))
			break;
		sc->path[d] = sc->interp[s];
	}

	ret = bpf_binprm_set_interp(bprm, sc->path, rsz);
	if (!ret)
		ret = 1;
out_del:
	bpf_map_delete_elem(&scratch_map, &id);
out:
	bpf_dynptr_file_discard(&dp);
	return ret;
}

SEC(".struct_ops.link")
struct binfmt_misc_ops nix_origin = {
	.load = (void *)nix_origin_load,
	.name = "nix_origin",
};

--7accz5oj66ddjm3r--
